# Carbon-Credit-Blockchain
# Problem defination 
Bring transparency in carbon credits 

Carbon credit calculation today depends on manual data gathering and disclosure. The vetting process is also manual with a lack of transparency making it non-trustworthy. With blockchain based carbon credit calculation, vetting can be done in an immutable, transparent and automated manner with organizations, industry partners and vetting agencies working in a single source of blockchain ledger.

## Following problems has been identified and intended to be solved:

Low investigatory capacity
	Authority Audits and Public audits can be possible for validation of Carbon 	Credits.

Low tracking of vetting history and past performance
	Low vetting performance tracking that enables repeat participation by 	corrupt or low performance vetting agencies.

Decisions made and reviewed by only one person 
	Blockchain Technology will help to withhold “Four Eyes Principle” 

Other problems such as Low Transparency, Inadequate records, Manipulation of data, Vetting agencies eligibility criteria's etc could be managed with the proposed models


# Working and design
Designed solution can help to identify and authenticate the owner ID of the certificate and also track the movement of certificate as it passes through the chain.

Different tools used for designing the solution were
Ethereum as  decentralized blockchain platform 
Truffle for compiling, deploying and linking smart contracts.
Ganache as a personal blockchain to test the dApps
Geth for running Ethereum node
Web3 to interact with Ethereum nodes locally or remotely
Microsoft Visual Studio used as an integrated development environment for project

Designed solutions enables organization to get Provenance which  enables them to easily collate their carbon credit data, along with other open data, and also verify key information (e.g. validity period of the certificate issued) on an immutable data ledger

![image](https://user-images.githubusercontent.com/69318648/142757011-7255b210-6520-476e-b9cc-92d66d5a3922.png)

1.  Three entities are encoded and can exchange carbon credit certificates among themselves which are vetting agencies, company or industry and there different subsidiaries.

2.  Protocols established are 
Only vetting agencies can publish the initial certificate.
Only after CFV (Carbon Footprint Verification)  which is fundamental to provide credibility to the issued certificate by vetting agencies, a certificate can be transferred further.
Registration for CFV authorities would be done in the initial phase.
To transfer certificates from company to its subsidiaries .newowner() function is used and the hash address has to be known of the subsidiary for successful transfer.

3.   Command Line testing is preferred due to its quick and flexible nature  and good for one time tests. Following factors were considered during testing.
Checking Overflows&underflows, boundary conditions, input and output data validation, iteration limits.

4. A total of 2 smart contracts were deployed one for carbon credit certificates and one for token (ERC20 standard)
![image](https://user-images.githubusercontent.com/69318648/142759006-cf328c50-6c3a-4f5e-b4a1-edb996f4e8e9.png)


