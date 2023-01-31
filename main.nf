#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

/* Prints help when asked for and exits */
def helpMessage() {
    log.info"""
    =========================================
    OmicsEV
    =========================================
    Usage:
    nextflow run main.nf
    Arguments:
      --data_dir          
      --sample_list       
      --x2                
      --x2_label         
      --use_existing_data
      --data_type        
      --class_for_ml
      --outdir
      --help
    """.stripIndent()
}

// Show help emssage
if (params.help) {
    helpMessage()
    exit 0
}

checkPathParamList = [params.data_dir, params.sample_list, params.x2, params.class_for_ml, params.outdir]
for (param in checkPathParamList) { if (param) { file(param, checkIfExists: true) } }

if (params.data_dir) { data_dir     = file(params.data_dir)  } else { exit 1, 'No directory specified with --data_dir'  }

/*
checkPathParamList = [params.d1_file, params.d2_file, params.cli_file]
for (param in checkPathParamList) { if (param) { file(param, checkIfExists: true) } }

if (params.d1_file) { d1_file     = file(params.d1_file)  } else { exit 1, 'No file specified with --d1_file'  }
if (params.d1_file) { d2_file     = file(params.d2_file)  } else { exit 1, 'No file specified with --d2_file'  }
if (params.d1_file) { sample_file = file(params.cli_file) } else { exit 1, 'No file specified with --cli_file' }

log.info "Sample attribute will be used: $params.cli_attribute \n"
*/

process OMICSEV {
    label 'process_medium'

    input:
    val data_dir
    val sample_list
    val x2
    val x2_label
    val use_existing_data
    val data_type
    val class_for_ml
    val outdir

    output:
    path outdir2

    script:
    println "cpus = ${task.cpus}"
    println "task = ${task}"
    """
    run_OmicsEV.R \\
        --data_dir="$data_dir" \\
        --sample_list="$sample_list" \\
        --x2="$x2" \\
        --x2_label="${params.x2_label}" \\
        --cpu="${task.cpus}" \\
        --use_existing_data="${params.use_existing_data}" \\
        --data_type="${params.data_type}" \\
        --class_for_ml="$class_for_ml" \\
        --out_dir="$outdir"
    """

}

workflow {
    OMICSEV(params.data_dir, params.sample_list, params.x2, params.x2_label, params.use_existing_data, params.data_type, params.class_for_ml, params.outdir)
}