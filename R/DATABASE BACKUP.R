# Sys.unsetenv("GITHUB_PAT") # Remove personal token to source startup()
source('~/Box/Yama/Startup_2022.R') 
startup()
# Backup Protect Database on Redcap
bsrc.conredcap2(protocol=ptcs$protect)

# Backup Masaterdemo Database on Redcap
bsrc.conredcap2(protocol=ptcs$masterdemo) 
