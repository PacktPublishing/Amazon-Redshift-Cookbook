# Amazon Redshift Cookbook

<a href="https://www.packtpub.com/in/data/amazon-redshift-cookbook"><img src="https://www.packtpub.com/media/catalog/product/cache/c2dd93b9130e9fabaf187d1326a880fc/9/7/9781800569683-original_161.jpeg" alt="Book Name" height="256px" align="right"></a>

This is the code repository for [Amazon Redshift Cookbook](https://www.packtpub.com/in/data/amazon-redshift-cookbook), published by Packt.

**Recipes for building modern data warehousing solutions**

## What is this book about?
Amazon Redshift is a fully managed, petabyte-scale AWS cloud data warehousing service. It enables you to build new data warehouse workloads on AWS and migrate on-premises traditional data warehousing platforms to Redshift.
This book on Amazon Redshift starts by focusing on Redshift architecture, showing you how to perform database administration tasks on Redshift. You'll then learn how to optimize your data warehouse to quickly execute complex analytic queries against very large datasets.

This book covers the following exciting features: 
* Use Amazon Redshift to build petabyte-scale data warehouses that are agile at scale
* Integrate your data warehousing solution with a data lake using purpose-built features and services on AWS
* Build end-to-end analytical solutions from data sourcing to consumption with the help of useful recipes
* Leverage Redshift's comprehensive security capabilities to meet the most demanding business requirements
* Focus on architectural insights and rationale when using analytical recipes
* Discover best practices for working with big data to operate a fully managed solution

If you feel this book is for you, get your [copy](https://www.amazon.in/Amazon-Redshift-Cookbook-warehousing-solutions-ebook/dp/B092ZYFXNX/ref=sr_1_2?dchild=1&keywords=amazon+redshift+cookbook&qid=1624618103&s=digital-text&sr=1-2) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" alt="https://www.packtpub.com/" border="5" /></a>

## Instructions and Navigations
All of the code is organized into folders. For example, Chapter06.

The code will look like the following:
```
create database ods;
CREATE TABLE ods.part 
(
  P_PARTKEY       BIGINT NOT NULL,
  P_NAME          VARCHAR(55),
  P_MFGR          VARCHAR(25),
  P_BRAND         VARCHAR(10),
  P_TYPE          VARCHAR(25),
  P_SIZE          INTEGER,
  P_CONTAINER     VARCHAR(10),
  P_RETAILPRICE   DECIMAL(18,4),
  P_COMMENT       VARCHAR(23)
); 

```
**Following is what you need for this book:**
This book is for anyone involved in architecting, implementing, and optimizing an Amazon Redshift data warehouse, such as data warehouse developers, data analysts, database administrators, data engineers, and data scientists. Basic knowledge of data warehousing, database systems, and cloud concepts and familiarity with Redshift will be beneficial.

With the following software and hardware list you can run all code files present in the book (Chapter 1-10).

### Software and Hardware List

| Chapter  | Software required                                                                                  | OS required                        |
| -------- | ---------------------------------------------------------------------------------------------------| -----------------------------------|
| 1-10     | AWS Account, SQL Workbench/J, Python 3.x, An IDE												                            | Windows, Mac OS X, and Linux (Any) |


We also provide a PDF file that has color images of the screenshots/diagrams used in this book. [Click here to download it]( https://static.packt-cdn.com/downloads/9781800569683_ColorImages.pdf).

### Related products <Other books you may enjoy>
* Azure Data Factory Cookbook[[Packt]](https://www.packtpub.com/product/azure-data-factory-cookbook/9781800565296) [[Amazon]](https://www.amazon.com/Azure-Data-Factory-Cookbook-integration/dp/1800565291)

* Snowflake Cookbook [[Packt]](https://www.packtpub.com/product/snowflake-cookbook/9781800560611) [[Amazon]](https://www.amazon.in/Snowflake-Cookbook-Techniques-warehousing-solutions/dp/1800560613)

## Get to Know the Authors
**Shruti Worlikar**
She is a cloud professional with technical expertise in data lakes and analytics across cloud platforms. Her background has led her to become an expert in on-premises-to-cloud migrations and building cloud-based scalable analytics applications.Her work history includes work at J.P. Morgan Chase, MicroStrategy, and Amazon Web Services (AWS). She is currently working in the role of Manager, Analytics Specialist SA at AWS, helping customers to solve real-world analytics business challenges with cloud solutions and working with service teams to deliver real value.

**Thiyagarajan Arumugam**
He is a principal big data solution architect at AWS, architecting and building solutions at scale using big data to enable data-driven decisions. Prior to AWS, Thiyagu as a data engineer built big data solutions at Amazon, operating some of the largest data warehouses and migrating to and managing them. He has worked on automated data pipelines and built data lake-based platforms to manage data at scale for the customers of his data science and business analyst teams. 
  
**Harshida Patel**
She is a senior analytics specialist solution architect at AWS, enabling customers to build scalable data lake and data warehousing applications using AWS analytical services. She has presented Amazon Redshift deep-dive sessions at re:Invent. Harshida has a bachelor’s degree in electronics engineering and a master’s in electrical and telecommunication engineering. She has over 15 years of experience architecting and building end-to-end data pipelines in the data management space. In the past, Harshida has worked in the insurance and telecommunication industries.
### Download a free PDF

 <i>If you have already purchased a print or Kindle version of this book, you can get a DRM-free PDF version at no cost.<br>Simply click on the link to claim your free PDF.</i>
<p align="center"> <a href="https://packt.link/free-ebook/9781800569683">https://packt.link/free-ebook/9781800569683 </a> </p>