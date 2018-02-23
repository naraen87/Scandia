set echo on 
spool C:\Users\SVCT-WI-Jenkins\Desktop\Scripts_for_ORF2\Input_File_For_Deployment\DB_Scripts\sql_property_del_script_5-JUL-17.lst

show user
show parameter db_name

DELETE FROM ba_xml where property_id in (select property_id from ba_properties where submod_id in (select submod_id FROM ba_submodules where mod_id in (select mod_id from ba_modules where PROFILE_ID in (select PROFILE_id from ba_profiles where PROFILE='INTRANET'))));
DELETE FROM ba_properties where submod_id in (select submod_id FROM ba_submodules where mod_id in (select mod_id from ba_modules where PROFILE_ID in (select PROFILE_id from ba_profiles where PROFILE='INTRANET')));
DELETE FROM ba_submodules where mod_id in (select mod_id from ba_modules where PROFILE_ID in (select PROFILE_id from ba_profiles where PROFILE='INTRANET'));
DELETE FROM ba_modules WHERE PROFILE_id IN (SELECT PROFILE_id FROM ba_profiles WHERE PROFILE='INTRANET');
DELETE FROM ba_profiles where PROFILE='INTRANET'; 

spool off