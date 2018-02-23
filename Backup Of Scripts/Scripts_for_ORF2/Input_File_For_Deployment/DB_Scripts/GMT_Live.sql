spool GMT.log;

update qz_dates set qz_dt= trunc(sysdate);
update qz_dates_back set qz_dt= trunc(sysdate);
update ac_dates set ac_dt= trunc(sysdate);
update sbd_sys_bsns_dts set SBD_BSNS_DT= trunc(sysdate), SBD_PRV_BSNS_DT= trunc(sysdate-1), SBD_NXT_BSNS_DT= trunc(sysdate+1) ;


Insert into PSO_RUN_CHECK (STAT,LAST_RUN_DATE,OU_ID,JOB_NAME,JOB_ID,PSO_RUN_CHECK_VER,DM_LSTUPDDT) values (1,trunc(sysdate),'GLALG','FX Rollover Position',93,1,sysdate);
Insert into PSO_RUN_CHECK (STAT,LAST_RUN_DATE,OU_ID,JOB_NAME,JOB_ID,PSO_RUN_CHECK_VER,DM_LSTUPDDT) values (1,trunc(sysdate),'GSLAL','FX Rollover Position',93,1,sysdate);
Insert into PSO_RUN_CHECK (STAT,LAST_RUN_DATE,OU_ID,JOB_NAME,JOB_ID,PSO_RUN_CHECK_VER,DM_LSTUPDDT) values (1,trunc(sysdate),'GSLIL','FX Rollover Position',93,1,sysdate);

delete from QRTZONE_CRON_TRIGGERS;
delete  from QRTZONE_TRIGGERS;
delete from QRTZONE_SIMPLE_TRIGGERS;
delete from QRTZONE_JOB_DETAILS;
delete from QRTZ_EXECUTION_DETAILS;
delete from qrtzone_fired_triggers; 

update batch_job_execution a set a.end_time=localtimestamp,a.status='ABANDONED',a.exit_code='Manually Updated' where a.end_time is null
and a.job_execution_id in (select b.job_execution_id from batch_job_execution b,batch_job_instance c
where b.job_instance_id=c.job_instance_id and (c.job_name not like 'SI%ProcessorJob' 
and substr(c.job_name,4) not in ('113','120','163','165','176','181','2207','250','251','253','254','255',
'256','257','260','262','265','591','600','6010','610','611','630','65195','659','6668','6682','75','85003','85004')));

update batch_step_execution a set a.end_time=localtimestamp,a.status='ABANDONED',a.exit_code='Manually Updated' where a.end_time is null
and a.step_execution_id in (
select d.step_execution_id from batch_job_execution b,batch_job_instance c,batch_step_execution d
where b.job_instance_id=c.job_instance_id and b.job_execution_id=d.job_execution_id and 
(c.job_name not like 'SI%ProcessorJob' and substr(c.job_name,4) 
not in ('113','120','163','165','176','181','2207','250','251','253','254','255','256','257',
'260','262','265','591','600','6010','610','611','630','65195','659','6668','6682','75','85003','85004'))); 

commit;

spool off;

