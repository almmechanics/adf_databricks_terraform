// Databricks notebook source
// DBTITLE 1,Connect to the Databricks Java logger
import org.apache.log4j.LogManager
val log = LogManager.getRootLogger

// COMMAND ----------

// DBTITLE 1,Custom log function
def logContext(message: String):String = {
  message + " [" + spark.conf.get("spark.databricks.clusterUsageTags.clusterId") + " " + dbutils.notebook.getContext.notebookPath + "]"
}

// COMMAND ----------

// DBTITLE 1,Simple logging actions
log.warn(logContext("WARN: App Insights from a Scala Notebook"))
log.info(logContext("INFO: App Insights from a Scala Notebook"))
log.error(logContext("ERROR: App Insights from a Scala Notebook"))
