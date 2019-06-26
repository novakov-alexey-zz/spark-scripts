import org.apache.spark.SparkContext
import org.apache.spark.SparkConf

// copy exisiting configuration and set new properties
val conf = new SparkConf().setAll(spark.conf.getAll).set("spark.executor.instances", "2")
//conf.getAll.foreach{ case (k,v) => println(s"$k : $v")}

// stop existing context
sc.stop

// create new session 
import org.apache.spark.sql.SparkSession
val spark = SparkSession.builder().appName("my-app").config(conf).getOrCreate()

// get new context
val sc1 = spark.sparkContext

// run some word count program
// gcs jar needs to be in CLASSPATH of driver as well
val data = sc1.textFile("gs://spark-test-244110_datasets/pg2690.txt")
val res = data.flatMap(_.split(" ")).filter(_.trim.nonEmpty).map((_, 1)).reduceByKey(_ + _).sortBy(_._2, false).take(100)
res.foreach{ case (w, c) => println(s"$c: $w")}