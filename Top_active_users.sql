select a.name, clogs.number_of_calls from (select cl.UID, count(cl.UID) as number_of_calls from call_logs cl
group by cl.UID) as clogs
join accounts a on clogs.UID=a.UID
order by 2 desc
limit 10;