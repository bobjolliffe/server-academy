# DHIS2 Security Discussion Accra 2017
(TODO: work this into a real set of guidelines)

## Security Management
Information security is not primarily a technical issue.  As technical people we are entrusted with running secure systems, often carrying sensitive health data.  There are *always* risks and vulnerabilities in any setup.  The important thing from a professional perspective is that we manage those risks within a clear and authoritative framework.  When breaches do happen it is important to be able to demonstrate that we have worked diligently within that framework to manage those risks and that we can demonstrate best effort.  Failure to do that is what leaves you open to claims of negligence and liability.

There are many standards and guidelines to security standards, but they all start from the same premise:  Good security starts with good management and commitment from the highest level of management.  

Security management system (like ISO 27001).  There a lot of free online materials to get you started.  For [example](https://www.google.rw/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=iso+27000+toolkit&*).   A security management system is not a computer program like virus protection software.  It is a set of processes, human practices and artefacts which together form the basis of managing security over time.

### Steps towards an effective information security management system (ISMS)
1.  Secure the support of top-level management.  Technicians do not have the mandate to enforce an effective security management system. 
2.  Have a high level 1 page security statement which makes clear the scope and the principles underlying the system.  This shouldn't be more than one page (or people won't read it) but it should lay out the principles from which the detailed practices will follow.  The scope of the ISMS we discuss here, for example, is restricted to managing the backend of a dhis2 server. 
3.  Ensure that their is a role within the organisation responsible for implementing the security management system - a chief information security officer.  The CISO should be accountable to management, ideally reporting monthly on security related goals, tasks and incidents.
4.  There are many important artefacts to manage in an ISMS.  Three of the most important are:
4.1  The risk management register
4.2  The backup/archiving plan
4.3  The incident response plan

The links above related to ISO27000 provide good guidelines for 
Beware of encryption!  You **must** have very detailed guidelines about management of keys.  If you lose them you can lose access to your data.

Have and enforce an access policy (front and back end).  NDAs for external support.  Link with HR process to handle personell exiting the service. 

## Some examples of vulnerabilities
1.  negligence leading to data loss (documented and tested backup plan)
2.  user behaviour - sharing of passwords, browsing links while logged in to the application (security section should be part of all user training)
3.  poor system administration - many sudo enabled accounts, poor ssh setup, not patching security upgrades
4.  lax postgresql security
5.  web application vulnerabilities.  DHIS2 is a large complex application with over 300 external dependencies.  It can and will have vulnerabilities.
6.  improper securing, handling and transporting of bckup files
7.  physical access (can you trust your cloud provider?  why?)

## Technical Measures
1. Strict security guidelines for all server setups (ssh, ssl, firewall etc).  Preferably automate installation to enforce standards. 
2. Automated backup and archiving.  (test the backups).
3. Intrusion detection.  Simple tools like fail2ban and logwatch are useful.  More complex IDS like ossec is recommended for more complex and sensitive environments.
4. Centralized logging systems are very valuable - like splunk, elk stack, [graylog](https://www.graylog.org/).
5. Containerization.  Limit web application's access to the database.
6. Web application firewall.  Might be possible to virtually patch.
7. Consider geoip blocking (most attacks originate from US, Russia, China rather than say Gambia) 

## Issues around patient and transactional data
Be familiar with your own legislative environment.  Many countries will have laws which require at the least that you have a documented security management plan with regular audit and evidence that you are making a best effort to implement it.  Failure to comply can place you at risk of arrest.

Extra precautions need to be taken to restrict unauthorized access to data.  For example:
1.  Field level encryption of identifying information (dhis2 feature - requires modification of default java security)
2.  Storing database on an encrypted filesystem (dataa encrypted at rest)
3.  Encrypting backup files
4.  More conservative database settings to reduce risk of data loss
5.  No matter how secure we make our server, there is always a risk of client devices (desktops, laptops, phones etc) being compromised.  For patient based systems there are standards to consider which insist on bi-directional node authentication (ATNA).

No matter how diligent you are, there will always be vulnerabilities and security related incidents (eg. the recent struts vulnerability).

You need an incident response process as part of security management plan.  (Incorporate sending message to security@dhis2.org).   

DHIS2 developer team are racing to tighten up security on the application side.  You need to keep up with incremental upgrades (and migrate off old versions).



