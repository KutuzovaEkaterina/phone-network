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

