rule align_pe:
    input:
        fq1="output/trimmed/{sample}-{unit}.1.trim.fastq.gz",
        fq2="output/trimmed/{sample}-{unit}.2.trim.fastq.gz"
    output:
        # see STAR manual for additional output files
        "star/{sample}-{unit}/Aligned.pe.out.bam",
        "star/{sample}-{unit}/ReadsPerGene.pe.out.tab"
    log:
        "logs/star/{sample}-{unit}.pe.log"
    params:
        # path to STAR reference genome index
        index=config["ref"]["index"],
        # optional parameters
        extra="--quantMode GeneCounts --sjdbGTFfile {} {}".format(
              config["ref"]["annotation"], config["params"]["star"])
    threads: 24
    wrapper:
        "0.63.0/bio/star/align"

rule align_se:
    input:
        fq1="output/trimmed/{sample}-{unit}.trim.fastq.gz"
    output:
        # see STAR manual for additional output files
        "star/{sample}-{unit}/Aligned.se.out.bam",
        "star/{sample}-{unit}/ReadsPerGene.se.out.tab"
    log:
        "logs/star/{sample}-{unit}.se.log"
    params:
        # path to STAR reference genome index
        index=config["ref"]["index"],
        # optional parameters
        extra="--quantMode GeneCounts --sjdbGTFfile {} {}".format(
              config["ref"]["annotation"], config["params"]["star"])
    threads: 24
    wrapper:
        "0.63.0/bio/star/align"

