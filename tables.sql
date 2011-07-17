-- MySQL dump 10.13  Distrib 5.1.54, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: ainews
-- ------------------------------------------------------
-- Server version	5.1.54-1ubuntu4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cat_corpus`
--

DROP TABLE IF EXISTS `cat_corpus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_corpus` (
  `urlid` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(1000) NOT NULL,
  `title` varchar(1024) NOT NULL,
  `content` text NOT NULL COMMENT 'full text',
  `adminrate` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`urlid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6393 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cat_corpus_cats`
--
-- This table would allow one article to have multiple categories,
-- by having multiple rows with the same urlid

DROP TABLE IF EXISTS `cat_corpus_cats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cat_corpus_cats` (
  `urlid` int(11) NOT NULL,
  `category` varchar(255) NOT NULL,
  KEY `urlid` (`urlid`),
  KEY `category` (`category`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dup`
--

DROP TABLE IF EXISTS `dup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dup` (
  `dupid` int(11) NOT NULL AUTO_INCREMENT,
  `centroid` int(11) DEFAULT NULL,
  `comment` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`dupid`),
  UNIQUE KEY `centroid` (`centroid`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dupurl`
--

DROP TABLE IF EXISTS `dupurl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dupurl` (
  `dupid` int(11) NOT NULL,
  `urlid` int(11) NOT NULL,
  UNIQUE KEY `urlid` (`urlid`),
  KEY `dupid` (`dupid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sources`
--

DROP TABLE IF EXISTS `sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(400) CHARACTER SET utf8 NOT NULL,
  `parser` varchar(100) NOT NULL COMMENT 'used by AINewsSourceParser.py',
  `description` varchar(32) NOT NULL,
  `status` int(1) NOT NULL COMMENT 'enabled (1) or not (0)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `textwordurl`
--

DROP TABLE IF EXISTS `textwordurl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `textwordurl` (
  `urlid` mediumint(9) NOT NULL COMMENT 'foreign key to urllist',
  `wordid` mediumint(9) NOT NULL COMMENT 'foreign key to wordlist',
  `freq` smallint(8) NOT NULL COMMENT 'freq of word in article',
  KEY `wordidx` (`urlid`,`wordid`),
  KEY `locidx` (`urlid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `urllist`
--

DROP TABLE IF EXISTS `urllist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `urllist` (
  `rowid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'used as foreign key "urlid" elsewhere',
  `url` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'news URL address',
  `initsvm` float DEFAULT NULL COMMENT 'initial SVM score',
  `svmscore` float DEFAULT NULL COMMENT 'SVM predicted score',
  `finalscore` float DEFAULT NULL COMMENT 'final adjusted score',
  `rate` float DEFAULT NULL COMMENT 'avg. ratings',
  `adminrate` float DEFAULT NULL COMMENT 'avg. ratings by admins',
  `ratesd` float DEFAULT NULL COMMENT 'standard deviation of all ratings',
  `ratecount` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'total number of ratings',
  `textlen` mediumint(9) NOT NULL DEFAULT '0' COMMENT 'count of words of the whole news story',
  `tag` varchar(32) CHARACTER SET utf8 DEFAULT NULL COMMENT 'news source type/description',
  `topic` varchar(16) DEFAULT NULL COMMENT 'category found by classifier',
  `pubdate` date DEFAULT NULL COMMENT 'news published date',
  `crawldate` date DEFAULT NULL COMMENT 'news crawled date',
  `publisher` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT 'news source',
  `title` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT 'news title',
  `description` varchar(4096) CHARACTER SET utf8 DEFAULT NULL COMMENT 'short abstract of the story',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `url` (`url`),
  KEY `crawldate` (`crawldate`,`pubdate`),
  KEY `tag` (`tag`)
) ENGINE=MyISAM AUTO_INCREMENT=1628 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wordlist`
--

DROP TABLE IF EXISTS `wordlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wordlist` (
  `rowid` mediumint(9) NOT NULL AUTO_INCREMENT COMMENT 'used as foreign key elsewhere',
  `word` varchar(300) CHARACTER SET utf8 NOT NULL COMMENT 'actual English word',
  `dftext` int(11) NOT NULL DEFAULT '0' COMMENT '# of articles with this word',
  PRIMARY KEY (`rowid`),
  UNIQUE KEY `word` (`word`)
) ENGINE=MyISAM AUTO_INCREMENT=113244 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wordlist_eval`
--
-- This table is often used by AINewsCentroidClassifier for experiments;
-- it has identical structure to wordlist

DROP TABLE IF EXISTS `wordlist_eval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wordlist_eval` (
  `rowid` mediumint(9) NOT NULL AUTO_INCREMENT,
  `word` varchar(300) CHARACTER SET utf8 NOT NULL,
  `dftext` int(11) NOT NULL DEFAULT '0' COMMENT 'text doc freq',
  PRIMARY KEY (`rowid`)
) ENGINE=MyISAM AUTO_INCREMENT=3133 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-07-16 10:06:06
