
#------------------------------------------------------------------------------------

## Loading the library
library("survival")
library("survminer")



#------------------------------------------------------------------------------------
## Creating the demo data set
set.seed(123)
d.demo <- data.frame(
  os.time = colon$time, 
  os.status = colon$status,
  pfs.time = sample(colon$time),
  pfs.status = colon$status,
  sex = colon$sex, rx = colon$rx, adhere = colon$adhere
)



#------------------------------------------------------------------------------------
## Combined Null Model
pfs <- survfit( Surv(pfs.time, pfs.status) ~ 1, data = d.demo)
os <- survfit( Surv(os.time, os.status) ~ 1, data = d.demo)

fit <- list(PFS = pfs, OS = os)
ggsurvplot(fit, data = d.demo, combine = TRUE, # Combine curves
           risk.table = TRUE,                  # Add risk table
           conf.int = TRUE,                    # Add confidence interval
           conf.int.style = "step",            # CI style, use "step" or "ribbon"
           censor = TRUE,                     # Remove censor points
           tables.theme = theme_cleantable(),  # Clean risk table
           palette = "jco")






#------------------------------------------------------------------------------------
# Combined Stratified Curve

pfs <- survfit( Surv(pfs.time, pfs.status) ~ rx, data = d.demo)
os <- survfit( Surv(os.time, os.status) ~ rx, data = d.demo)



fit <- list(PFS = pfs, OS = os)
ggsurvplot(fit, data = d.demo, combine = TRUE,     # Combine curves
           risk.table = TRUE, tables.height = 0.35, # Adjust tables height
           tables.theme = theme_cleantable(),       # Clean risk table
           censor = FALSE,                          # Remove censor points
           palette = "jco"
)