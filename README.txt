Desarrollo de tablas a ser consumidas por Qlik Sense Canada

# Run On Demand
nohup java -cp ~/OracleExtractor/Bin/V11/Bimbo-Scheduler-1.0.0.jar com.twobig.bimbo.schedules.task.OrchestratorTask ~/OracleExtractor/Tasks/OrchestratorTask/canadaTask/vista.json > canada.manual.out &


# Location for Orchestrator Log
/tmp/Logs/Operations/{user}/Orchestrator/{year}}/{month}/{day}/{taskId}/{project_desc}/{step_desc}/

# Orchestrator Log File
fileName_HH_mm_ss_ms.log


# Query to check the execution status
select * from operation_stats.orchestrator_execution_summary order by start_time desc

