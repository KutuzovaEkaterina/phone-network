# phone-network

In my opinion, the scheme of database doesn't correct on the 100 percent. Primary and foreign keys are missing, therefore sql queries look difficult. In addition, the table "Rates" isn't related with other tables (e.g. "Call_logs"). Moreover, the table "Call_forvarding" is reduntant in this case. Thus, I propose the new scheme, which, in my mind, is better.

Please look at the Wiki pages:
* https://github.com/KutuzovaEkaterina/phone-network/wiki/Old-diagram
* https://github.com/KutuzovaEkaterina/phone-network/wiki/New-diagram
