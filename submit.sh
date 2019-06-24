SPARK_IMAGE="gcr.io/spark-test-244110/spark:2.4.3"
SPARK_HOME="/home/an/spark-2.4.3-bin-hadoop2.7"

$SPARK_HOME/bin/spark-submit \
--master k8s://http://127.0.0.1:8001 \
--deploy-mode client \
--conf spark.executor.instances=3 \
--conf spark.driver.host=10.128.0.4 \
--conf spark.driver.port=34729 \
--conf spark.port.maxRetries=100 \
--conf spark.driver.memory=512m \
--conf spark.executor.memory=512m \
--conf spark.kubernetes.namespace=default \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
--class org.apache.spark.examples.SparkPi \
--name spark-pi \
--conf spark.kubernetes.container.image=$SPARK_IMAGE \
file://$SPARK_HOME/examples/jars/spark-examples_2.11-2.4.3.jar
