rule trim_pe:
    input:
        r1=lambda wildcards: "data/" + units.loc[(wildcards.sample, wildcards.unit), "fq1"],
        r2=lambda wildcards: "data/" + units.loc[(wildcards.sample, wildcards.unit), "fq2"]
    output:
        r1=temp("output/trimmed/{sample}-{unit, [^.]+}.1.trim.fastq.gz"),
        r2=temp("output/trimmed/{sample}-{unit, [^.]+}.2.trim.fastq.gz"),
        r1_unpaired=temp("output/trimmed/{sample}-{unit, [^.]+}.1.unpaired.fastq.gz"),
        r2_unpaired=temp("output/trimmed/{sample}-{unit, [^.]+}.2.unpaired.fq.gz")
    log:
        "output/logs/trimmomatic/{sample}-{unit}.trimmomatic.log"
    params:
        trimmer=["ILLUMINACLIP:" + config["trimmomatic"]["adapter"] + config["trimmomatic"]["pe_adapter_trimmer"], config["trimmomatic"]["trimmer"]]
    threads:
        config["threads"]
    wrapper:
        "0.49.0/bio/trimmomatic/pe"

rule trim_se:
    input:
        lambda wildcards: "data/" + units.loc[(wildcards.sample, wildcards.unit), "fq1"]
    output:
        temp("output/trimmed/{sample}-{unit, [^.]+}.trim.fastq.gz")
    log:
        "output/logs/trimmomatic/{sample}-{unit}.trimmomatic.log"
    params:
        trimmer=["ILLUMINACLIP:" + config["trimmomatic"]["adapter"] + config["trimmomatic"]["se_adapter_trimmer"], config["trimmomatic"]["trimmer"]]
    threads:
        config["threads"]
    wrapper:
        "0.49.0/bio/trimmomatic/se"
