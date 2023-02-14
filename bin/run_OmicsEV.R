#!/usr/bin/env Rscript

library(docopt)

'Run OmicsEV.

Usage:
  run_OmicsEV --data_dir=<DIR> --sample_list=<FILE> --x2=<FILE> --x2_label=<STRING> --cpu=<INT> --use_existing_data=<BOOL> --data_type=<STRING> --class_for_ml=<FILE>
  run_OmicsEV (-h | --help)
  run_OmicsEV (-v | --version)

Options:
  -h --help             Show this screen.
  -v --version          Show version.
  --data_dir=<DIR>            testing
  --sample_list=<FILE>        testing
  --x2=<FILE>                 testing
  --x2_label=<STRING>         testing
  --cpu=<INT>                 testing
  --use_existing_data=<BOOL>  testing
  --data_type=<STRING>        testing
  --class_for_ml=<FILE>       testing
' -> doc

args <- docopt(doc, version = 'Run OmicsEV v1.0')
args$use_existing_data <- as.logical(toupper(args$use_existing_data))

command <- "R -e \"library(OmicsEV)
run_omics_evaluation(data_dir = '%s',sample_list = '%s',x2 = '%s',x2_label = '%s',cpu = $%s,use_existing_data = $%s,data_type = '%s',class_for_ml = '%s')\""
command <- sprintf(command, args$data_dir,args$sample_list,args$x2,args$x2_label,args$cpu, args$use_existing_data, args$data_type,args$class_for_ml)
system(command)

#library(OmicsEV)
#run_omics_evaluation(data_dir = args$data_dir,
#                     sample_list = args$sample_list,
#                     x2 = args$x2,
#                     x2_label = args$x2_label,
#                     cpu = args$cpu,
#                     use_existing_data = args$use_existing_data,
#                     data_type = args$data_type,
#                     class_for_ml = args$class_for_ml,
#                     out_dir = args$out_dir)
