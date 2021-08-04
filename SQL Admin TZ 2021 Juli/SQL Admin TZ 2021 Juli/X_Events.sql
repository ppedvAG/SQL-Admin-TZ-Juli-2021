CREATE EVENT SESSION [OrdersNwind2] ON SERVER 
ADD EVENT sqlserver.module_end(
    ACTION(sqlserver.client_hostname,sqlserver.database_id,sqlserver.database_name,sqlserver.server_instance_name,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[sql_text],N'orders'))),
ADD EVENT sqlserver.module_start(
    ACTION(sqlserver.client_hostname,sqlserver.database_id,sqlserver.database_name,sqlserver.server_instance_name,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[sql_text],N'orders'))),
ADD EVENT sqlserver.rpc_starting(
    ACTION(sqlserver.client_hostname,sqlserver.database_id,sqlserver.database_name,sqlserver.server_instance_name,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND [package0].[equal_boolean]([sqlserver].[is_system],(0)) AND [sqlserver].[like_i_sql_unicode_string]([sqlserver].[sql_text],N'%orders%'))),
ADD EVENT sqlserver.sp_statement_starting(
    ACTION(sqlserver.client_hostname,sqlserver.database_id,sqlserver.database_name,sqlserver.server_instance_name,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND [package0].[equal_boolean]([sqlserver].[is_system],(0)) AND [sqlserver].[like_i_sql_unicode_string]([sqlserver].[sql_text],N'%orders%'))),
ADD EVENT sqlserver.sql_batch_starting(
    ACTION(sqlserver.client_hostname,sqlserver.database_id,sqlserver.database_name,sqlserver.server_instance_name,sqlserver.session_id,sqlserver.sql_text)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND [package0].[equal_boolean]([sqlserver].[is_system],(0)) AND [sqlserver].[like_i_sql_unicode_string]([sqlserver].[sql_text],N'%orders%')))
ADD TARGET package0.event_file(SET filename=N'D:\_BACKUP\NwindOrders.xel')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=ON,STARTUP_STATE=OFF)
GO

