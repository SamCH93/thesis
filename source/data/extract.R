library(dplyr)
# download from https://osf.io/39s7j
dat <- read.csv("RP_CB Final Analysis - Effect level data.csv")
datClean <- dat |>
    select(paper = Paper.., experiment = Experiment.., effect = Effect..,
           internalReplication = Internal.replication..,
           smdo = Original.effect.size..SMD.,
           so = Original.standard.error..SMD., no = Original.sample.size,
           smdr = Replication.effect.size..SMD.,
           sr = Replication.standard.error..SMD. , nr = Replication.sample.size)
write.csv(x = datClean, file = "rpcb.csv", row.names = FALSE)
