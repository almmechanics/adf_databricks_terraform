# ADF Calling Databricks
# pylint: disable=E0602
# pylint: disable=C0301
# pylint: disable=W0212
# pylint: disable=R0801

# DBTITLE 1,Connect to the Databricks Java logger
"""Connection to Azure Databicks native logging"""

log4jref = sc._jvm.org.apache.log4j
LOGGER = log4jref.LogManager.getLogger('aiAppender')

# COMMAND ----------

# DBTITLE 1,Custom log function
def log_context (message) :
    """Add cluster and notebook context to log message"""

    cluster_id = spark.conf.get("spark.databricks.clusterUsageTags.clusterId")
    notebook = dbutils.notebook.entry_point.getDbutils().notebook().getContext().notebookPath().get()
    context_log_message = message + " [" + cluster_id + " " + notebook + "]"
    return context_log_message

# COMMAND ----------

# DBTITLE 1,Log Connection from ADF

dbutils.widgets.text("dataFactory", "","")
dbutils.widgets.get("dataFactory")

dbutils.widgets.text("pipelineRunId", "","")
dbutils.widgets.get("pipelineRunId")

LOGGER.info(log_context("Start: calling Databricks and invoking application insights from a Python Notebook"))
LOGGER.info(log_context("Info: calling from ADF "+ getArgument("dataFactory") + " using pipeline id "+ getArgument("pipelineRunId")))
LOGGER.info(log_context("Finish: calling Databricks and invoking application insights from a Python Notebook"))
