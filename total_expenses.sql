select 
  (select count(*)*(select money from rates where ID=1) from call_logs where call_logs.Call_dir='in') + -- expenses for all incoming calls  
  ((select count(*) from call_logs cl where cl.call_dir='out')-count(*))*(select money from rates where ID=2) + -- expenses for outgoing calls to phone numbers from Numbers table
  (count(*)*(select money from rates where ID=3)) -- expenses for all other outgoing calls
  as total_expenses
from numbers n
right join call_logs c on n.UID=c.UID where n.UID is null and c.Call_dir='out';