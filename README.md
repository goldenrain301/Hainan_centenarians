# A metagenomics study reveals the gut microbiome as a sex-specific modulator of healthy aging in Hainan centenarians

## Introduction
Analysis script for A metagenomics study reveals the gut microbiome as a sex-specific modulator of healthy aging in Hainan centenarians 

### Author
         Author:     Zhe Luan    
    Last update:     2022-06-18    

### Index
--------------------------------------------------------
1 Environment   
    1.1 System   
        1.1.1 System Platform   
        1.1.2 Hardware    
    1.2 FastQC    
    1.3 MetaPhlAn   
        1.3.1 MetaPhlAn version   
        1.3.2 System information   
    1.4 SOAPalign2   
    1.5 SOAPdenovo   
2 Data    
    2.1 original sequences 
3 Scripts   
    3.1 rmAdaptor.py   
    3.2 rmHost.pl  
    3.3 adonis.R  
4 Direction for use      
    4.1 Run pipeline

5 How to get the data?   
    5.1 How to get the original sequences?   
    

# 1 Environment
## 1.1 System
-------------------------------------------------------
### 1.1.1 System Platform
-------------------------------------------------------
    Platform:      CentOS 
     Version:      Linux version 2.6.32-642.13.1.el6.x86_64 (mockbuild@c1bm.rdu2.centos.org) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-17) (GCC) ) #1 SMP Wed Jan 11 20:56:24 UTC 2017
          OS:      CentOS release 6.8 (Final)
--------------------------------------------------------
### 1.1.2 Hardware
--------------------------------------------------------
         Cpu(s):      >10
         thread:      >10
            RAM:      >64G
      Hard disk:      >5T
--------------------------------------------------------
## 1.2 FastQC

-------------------------------------------------------

    FastQC: A Quality Control application for FastQ files.
    Language: JAVA（1.8.0_60）
    Version  0.11.8

--------------------------------------------------------



## 1.3 MetaPhlAn

--------------------------------------------------------
### 1.3.1 MetaPhlAn version
--------------------------------------------------------
      Version:      MetaPhlAn 2.5.0
--------------------------------------------------------
### 1.3.2 System information
--------------------------------------------------------
               Platform:      CentOS
         Python version:      Python 2.7.13 :: Anaconda custom (64-bit)
--------------------------------------------------------
## 1.4 SOAPalign2
-------------------------------------------------------
    Program for faster and efficient alignment for short oligonucleotide onto reference sequences. SOAPaligner/soap2 is compatible with numerous applications, including single-read or pair-end resequencing.
    Author: BGI
    Language: C
    Version 2.21
--------------------------------------------------------

## 1.5 SOAPdenovo

-------------------------------------------------------

    SOAPdenovo2: an empirically improved memory-efficient short-read denovo assembler.
    Author: BGI
    Language: perl（v5.20.2）
    Version 2.04

--------------------------------------------------------



# 2 Data

--------------------------------------------------------
## 2.1 original sequences
--------------------------------------------------------
     format of sequences :      fastq
       Number of fq files:      75
             fq_filenames:      54-1-C_1.fq
                                54-1-C_2.fq
                                90-1-C_1.fq
                                90-1-C_2.fq
                                154-1-C_1.fq
                                154-1-C_2.fq
                                ......
--------------------------------------------------------

# 3 Scripts
--------------------------------------------------------
## 3.1 rmAdaptor.py

--------------------------------------------------------

         Function:     Removes adapter sequences from high-throughput sequencing reads.
      Last updata:      2022-06-18
           Author:      Zhe Luan



## 3.2  rmHost.pl

--------------------------------------------------------

         Function:     Removes Host sequences from high-throughput sequencing reads.
      Last updata:      2022-06-18
           Author:      Zhe Luan



## 3.3  adonis.R

--------------------------------------------------------
         Function:       the abundent table analysis with adonis file.
      Last updata:      2022-06-18
           Author:      Zhe Luan
--------------------------------------------------------
## 4 Run pipeline
--------------------------------------------------------
### 4.1 Run pipeline
--------------------------------------------------------
     fastqc -q --extract -nogroup -o <output_dir> <fq_dir>
     rmAdaptor_20180110.py --type PE -r1 <fq_dir> -r2 <fq_dir> -a1 <adapter1> -a2 <adapter2> --out_prefix <output_dir> --out_type 2
     soap -r 1 -p 10 -m 100 -x 1000 -a <fq_dir> -b <fq_dir> -D hg38.fa.index -o <output_dir> -2 <output_dir>
     rmHost.pl <input_dir> <output_dir> <output_dir> <sample.name>
     metaphlan2.py <fq_dir>,<fq_dir>  --input_type fastq --bowtie2out output.bowtie2.bz2 --nproc 3 -o <output>
     Rscript adonis.R args <profile_file> <group_file> <env_file>
--------------------------------------------------------


# 5 How to get the data?   
--------------------------------------------------------
## 5.1 How to get the original sequences?   
--------------------------------------------------------
    The raw data of metagenomic analysis are available from the Sequence Read Archive (SRA) database of National Center for Biotechnology Information (NCBI) official website (accession number PRJNA904419).
--------------------------------------------------------

