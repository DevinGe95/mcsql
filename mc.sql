CREATE TABLE `germline_cnv` (
	`CNV.ID` INTEGER AUTO_INCREMENT UNIQUE,
	`Sample` VARCHAR(255),
	`Correlation` FLOAT,
	`N.comp` INTEGER,
	`N.exons` INTEGER,
	`CNV.type` CHAR(1),
	`Start` INTEGER,
	`End` INTEGER,
	`Chromosome` INTEGER,
	`Genmoics.ID` VARCHAR(255),
	`BF` FLOAT,
	`Reads.ratio` FLOAT,
	`Gene` VARCHAR(255),
	`Exon.start` VARCHAR(255),
	`Exon.end` VARCHAR(255),
	`Overlap` FLOAT,
	`US_ratio` FLOAT,
	`Cofidence` VARCHAR(255),
	`Genotype` VARCHAR(255),
	`INFO` VARCHAR(255),
	`Transcript` VARCHAR(255),
	PRIMARY KEY(`Sample`)
);


CREATE TABLE `germ_bed` (
	`chr` INTEGER UNIQUE,
	`start` INTEGER,
	`end` INTEGER,
	`gene` VARCHAR(255),
	PRIMARY KEY(`chr`, `start`, `end`)
);


CREATE TABLE `germ_exon` (
	`Chr` INTEGER AUTO_INCREMENT UNIQUE,
	`Start` INTEGER,
	`End` INTEGER,
	`Gene` VARCHAR(255),
	`Custom.Exon` INTEGER,
	PRIMARY KEY(`Chr`, `Start`, `End`)
);


CREATE TABLE `Origin_cnv_result` (
	`CNV.ID` INTEGER AUTO_INCREMENT UNIQUE,
	`Sample` VARCHAR(255),
	`Correlation` FLOAT,
	`N.comp` INTEGER,
	`N.exons` INTEGER,
	`CNV.type` CHAR(1),
	`Start` INTEGER,
	`End` INTEGER,
	`Chromosome` INTEGER,
	`Genmoics.ID` VARCHAR(255),
	`BF` FLOAT,
	`Reads.ratio` FLOAT,
	`Gene` VARCHAR(255),
	`Exon.start` VARCHAR(255),
	`Exon.end` VARCHAR(255),
	PRIMARY KEY(`Sample`)
);


CREATE TABLE `bam` (
	`Normal.bam path` VARCHAR(255) NOT NULL UNIQUE,
	PRIMARY KEY(`Normal.bam path`)
);


CREATE TABLE `unstable_bed` (
	`chr` INTEGER AUTO_INCREMENT UNIQUE,
	`start` INTEGER,
	`end` INTEGER,
	PRIMARY KEY(`chr`, `start`, `end`)
);


CREATE TABLE `Transcript` (
	`#gene_HGNC` VARCHAR(255) UNIQUE,
	`transcript` VARCHAR(255),
	PRIMARY KEY(`#gene_HGNC`)
);


CREATE TABLE `Normal_final_vcf` (
	`#CHROM` INTEGER AUTO_INCREMENT UNIQUE,
	`POS` INTEGER,
	`ID` CHAR(1),
	`REF` VARCHAR(255),
	`ALT` VARCHAR(255),
	`QUAL` FLOAT,
	`FILTER` VARCHAR(255),
	`INFO` VARCHAR(255),
	`FORMAT` VARCHAR(255),
	`SampleID` VARCHAR(255),
	PRIMARY KEY(`#CHROM`, `POS`, `REF`, `ALT`)
);


ALTER TABLE `bam`
ADD FOREIGN KEY(`Normal.bam path`) REFERENCES `Origin_cnv_result`(`Sample`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Origin_cnv_result`
ADD FOREIGN KEY(`Chromosome`) REFERENCES `unstable_bed`(`chr`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Origin_cnv_result`
ADD FOREIGN KEY(`Start`) REFERENCES `unstable_bed`(`start`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Origin_cnv_result`
ADD FOREIGN KEY(`End`) REFERENCES `unstable_bed`(`end`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Origin_cnv_result`
ADD FOREIGN KEY(`Gene`) REFERENCES `Transcript`(`#gene_HGNC`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Origin_cnv_result`
ADD FOREIGN KEY(`Sample`) REFERENCES `Normal_final_vcf`(`SampleID`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `unstable_bed`
ADD FOREIGN KEY(`chr`) REFERENCES `germline_cnv`(`Chromosome`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `unstable_bed`
ADD FOREIGN KEY(`start`) REFERENCES `germline_cnv`(`Start`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `unstable_bed`
ADD FOREIGN KEY(`end`) REFERENCES `germline_cnv`(`End`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Transcript`
ADD FOREIGN KEY(`#gene_HGNC`) REFERENCES `germline_cnv`(`Gene`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Transcript`
ADD FOREIGN KEY(`transcript`) REFERENCES `germline_cnv`(`Transcript`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `Normal_final_vcf`
ADD FOREIGN KEY(`SampleID`) REFERENCES `germline_cnv`(`Sample`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `germ_bed`
ADD FOREIGN KEY(`gene`) REFERENCES `Origin_cnv_result`(`Gene`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `germ_exon`
ADD FOREIGN KEY(`Gene`) REFERENCES `Origin_cnv_result`(`Gene`)
ON UPDATE NO ACTION ON DELETE NO ACTION;