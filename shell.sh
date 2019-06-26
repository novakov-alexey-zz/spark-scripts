kubectl proxy &

SPARK_IMAGE="gcr.io/spark-test-244110/spark:v2.4.3-gcs"
SPARK_HOME="/home/an/spark-2.4.3-bin-hadoop2.7"

$SPARK_HOME/bin/spark-shell \
--master k8s://http://127.0.0.1:8001 \
--deploy-mode client \
--conf spark.executor.instances=3 \
--conf spark.driver.host=10.128.0.9 \
--conf spark.driver.port=34729 \
--conf spark.port.maxRetries=100 \
--conf spark.driver.memory=512m \
--conf spark.executor.memory=512m \
--conf spark.kubernetes.namespace=default \
--conf spark.kubernetes.authenticate.driver.serviceAccountName=spark \
--name gce-vm-shell \
--conf spark.kubernetes.container.image=$SPARK_IMAGE 