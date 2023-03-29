## libraries
library(dplyr) # for data wrangling
library(ggplot2) # to reproduce plots from publication

## RPCB data with SMD transformed effect sizes but before aggregating internal replications
## https://github.com/mayamathur/rpcb/tree/master/Prepped%20data/Intermediate%20work
dat <- read.csv(file = "intermediate_dataset_step3.csv")
dat2 <- dat %>%
    filter(!is.na(origDirection),
           quantPair == TRUE)

## organize data set for reanalysis
datClean <- dat2 %>%
    mutate(
        ## define identifier for paper, experiment, effect, internal replication
        id = paste0("(", pID, ", ", eID, ", ", oID, ", ", internalID, ")")
    ) %>%
    select(
        osf = OSF.project.link,
        id,
        paper = pID,
        experiment = eID,
        effect = oID,
        internalReplication = internalID,
        resulto = origDirection,
        resultr = repDirection,
        ## effect sizes and standard errors on SMD scale
        smdo = origES3,
        so = origSE3,
        smdr = repES3,
        sr = repSE3,
        ## effect sizes, standard errors, p-values, confidence intervals on original scale
        effectType = Effect.size.type,
        ESo = Original.effect.size,
        seESo = Original.standard.error,
        lowerESo = Original.lower.CI,
        upperESo = Original.upper.CI,
        po = origPval,
        ESr = Replication.effect.size,
        seESr = Replication.standard.error,
        lowerESr = Replication.lower.CI,
        upperESr = Replication.upper.CI,
        pr = repPval,
        ## original and replication sample size
        ## (not clear whether group or full sample size)
        no = origN,
        nr = repN
    )


## should give 20 original null effects and 10 "successful" null replications
## (see null results in Table 1)
datClean %>%
    summarise(nulls = sum(resulto == "Null"),
              successes = sum(resulto == "Null" &
                              resultr %in% c("Null-positive", "Null-negative",
                                             "Null")))

## should give 112 original positive effects and 44 successful replications
datClean %>%
    summarise(positives = sum(resulto == "Positive"),
              successes = sum(resulto == "Positive" &
                              resultr == "Positive" &
                              sign(smdo) == sign(smdr)))

## save
write.csv(datClean, "rpcb-outcome-level.csv", row.names = FALSE)

## summarize internal replications with fixed-effect meta-analysis to get
## "effect-level data"
dat3 <- datClean %>%
    mutate(id2 = paste0("(", paper, ", ", experiment, ", ", effect, ")"))
datClean2 <- lapply(unique(dat3$id2), FUN = function(id2) {
    ## pool the internal replications with fixed-effect meta-analysis
    datr <- dat3[dat3$id2 == id2,]
    nreplications <- nrow(datr)
    varsmdrMA <- 1/sum(1/datr$sr^2)
    smdrMA <- sum(datr$smdr/datr$sr^2)*varsmdrMA
    ## add the sample sizes of the internal replications
    nrTotal <- sum(datr$nr)
    if (nreplications > 1) {
        ## check whether still a "null" replication based on Wald p-value
        prMA <- 2*pnorm(q = abs(smdrMA)/sqrt(varsmdrMA), lower.tail = FALSE)
        if (prMA > 0.05) {
            resultMA <- "Null"
        } else {
            resultMA <- "Positive"
        }
    } else {
        resultMA <- datr$resultr
    }
    out <- datr[1,] %>%
        mutate(smdr = smdrMA,
               sr = sqrt(varsmdrMA),
               nr = nrTotal,
               id = id2,
               resultr = resultMA) %>%
        select(-internalReplication, -id2)
    return(out)
}) %>%
    bind_rows()

## should give 15 original null effects and 11 "successful" null replications
## (see null results in Table 1)
datClean2 %>%
    summarise(nulls = sum(resulto == "Null"),
              successes = sum(resulto == "Null" &
                              resultr %in% c("Null-positive", "Null-negative",
                                             "Null")))

## should give 97 original positive effects and 42 successful replications
datClean2 %>%
    summarise(positives = sum(resulto == "Positive"),
              successes = sum(resulto == "Positive" &
                              resultr == "Positive" &
                              sign(smdo) == sign(smdr)))

## replicate Figure 1
## https://iiif.elifesciences.org/lax/71601%2Felife-71601-fig2-v3.tif/full/1500,/0/default.jpg
datClean2 %>%
    mutate(rsig = factor(pr <= 0.05, levels = c(FALSE, TRUE),
                         labels = c("italic(p[r]) > 0.05",
                                    "italic(p[r]) <= 0.05"))) %>%
    ggplot(aes(x = smdo, y = smdr)) +
    geom_abline(intercept = 0, slope = 1, alpha = 0.3) +
    geom_hline(yintercept = 0, lty = 2, alpha = 0.9, linewidth = 0.4) +
    geom_vline(xintercept = 0, lty = 2, alpha = 0.9, linewidth = 0.4) +
    geom_point(aes(fill = rsig), shape = 21, size = 2) +
    geom_rug(aes(color = rsig), size = 0.3, show.legend = FALSE) +
    labs(x = "Original effect estimate (SMD)",
         y = "Replication effect estimate (SMD)",
         fill = "") +
    coord_fixed(xlim = c(-5, 28), ylim = c(-5, 28)) +
    scale_x_continuous(breaks = seq(-5, 25, 5)) +
    scale_y_continuous(breaks = seq(-5, 25, 5)) +
    scale_fill_discrete(labels = scales::parse_format()) +
    theme_bw() +
    theme(panel.grid = element_blank(), legend.position = c(0.5, 0.835))

## save
write.csv(datClean2, "rpcb-effect-level.csv", row.names = FALSE)
