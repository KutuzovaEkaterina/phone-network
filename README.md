# phone-network

In my opinion, the scheme of database doesn't correct on the 100 percent. Primary and foreign keys are missing, therefore sql queries look difficult. In addition, the table "Rates" isn't related with other tables (e.g. "Call_logs"). Moreover, the table "Call_forvarding" is reduntant in this case. Thus, I propose the new scheme, which, in my mind, is better.

## Please look at the Wiki pages:
* https://github.com/KutuzovaEkaterina/phone-network/wiki/Old-diagram
* https://github.com/KutuzovaEkaterina/phone-network/wiki/New-diagram

## Sql requests:
 * Total expenses: https://github.com/KutuzovaEkaterina/phone-network/blob/master/total_expenses.sql
 ```sql 
 select 
  (select count(*)*(select money from rates where ID=1) from call_logs where call_logs.Call_dir='in') + -- expenses for all incoming calls  
  ((select count(*) from call_logs cl where cl.call_dir='out')-count(*))*(select money from rates where ID=2) + -- expenses for outgoing calls to phone numbers from Numbers table
  (count(*)*(select money from rates where ID=3)) -- expenses for all other outgoing calls
  as total_expenses
from numbers n
right join call_logs c on n.UID=c.UID where n.UID is null and c.Call_dir='out';
```
* Top 10: Most active users: https://github.com/KutuzovaEkaterina/phone-network/blob/master/Top_active_users.sql
 ```sql 
select a.name, clogs.number_of_calls from (select cl.UID, count(cl.UID) as number_of_calls from call_logs cl
group by cl.UID) as clogs
join accounts a on clogs.UID=a.UID
order by 2 desc
limit 10;
```
* Top 10: Users with highest charges, and daily distribution for each of them: https://github.com/KutuzovaEkaterina/phone-network/blob/master/Top_users_with_highest_charges.sql
 ```sql 
select a.name, r.total_expenses from (select c.UID,
  (select count(*)*(select money from rates where ID=1) from call_logs where call_logs.Call_dir='in' and call_logs.UID = c.UID) + -- expenses for all incoming calls for specific uid
  ((select count(*) from call_logs cl where cl.call_dir='out' and cl.UID=c.UID)-count(*))*(select money from rates where ID=2) + -- expenses for outgoing calls to phone numbers from Numbers table for specific uid
  (count(*)*(select money from rates where ID=3)) -- expenses for all other outgoing calls for specific uid
  as total_expenses
from numbers n
right join call_logs c on n.UID=c.UID where n.UID is null and c.Call_dir='out'
group by c.UID) as r
join accounts a on r.UID=a.UID
order by total_expenses desc
limit 10; -- top 10 users with highest charges
```
