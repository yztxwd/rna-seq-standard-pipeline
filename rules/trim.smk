def get_fastq(wildcards):
    return units.loc[(wildcards.sample, wildcards.unit), ["fq1", "fq2"]].dropna()

rule trim_pe:
    input:
        r1=lambda wildcards: "data/" + units.loc[(wildcards.sample, wildcards.unit), "fq1"],
        r2=lambda wildcards: "data/" + units.loc[(wildcards.sample, wildcards.unit), "fq2"],
        adapter=config["trimmomatic"]["adapter"]
    output:
        r1=temp("output/trimmed/{sample}-{unit}.1.fastq.gz"),
        r2=temp("output/trimmed/{sample}-{unit}.2.fastq.gz"),
        r1_unpaired=temp("output/trimmed/{sample}-{unit}.1.unpaired.fastq.gz"),
        r2_unpaired=temp("output/trimmed/{sample}-{unit}.2.unpaired.fq.gz")
    log:
        "output/logs/trimmomatic/{sample}-{unit}.trimmomatic.log"
    params:
        trimmer=["ILLUMINACLIP:" + config["trimmomatic"]["adapter"] + ":2:30:10", config["trimmomatic"]["trimmer"]]
    threads:
        config["threads"]
    wrapper:
        "0.49.0/bio/trimmomatic/pe"

rule trim_se:
    input:
        lambda wildcards: "data/" + units.loc[(wildcards.sample, wildcards.unit), "fq1"]
    output:
        temp("output/trimmed/{sample}-{unit, [^.]+}.fastq.gz")
    log:
        "output/logs/trimmomatic/{sample}-{unit}.trimmomatic.log"
    params:
        trimmer=["ILLUMINACLIP:" + config["trimmomatic"]["adapter"] + ":2:30:10", config["trimmomatic"]["trimmer"]]
    threads:
        config["threads"]
    wrapper:
        "0.49.0/bio/trimmomatic/se"
