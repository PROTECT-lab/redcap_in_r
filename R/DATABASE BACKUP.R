source('~/Box/Yama/Startup_2022.R') # CHANGE TO YOUR PATH
startup()
# Backup Protect Database on Redcap
bsrc.conredcap2(protocol=ptcs$protect)

# Backup Masaterdemo Database on Redcap
bsrc.conredcap2(protocol=ptcs$masterdemo) 
