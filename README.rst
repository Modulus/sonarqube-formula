===========================
sonarqube-formula
===========================

This formula will setup sonarqube for you. Currently only tested and verified on ubuntu 16.04 with systemd.

.. sonarqube.org: https://www.sonarqube.org/

Pillars
================
See pillar.example for config related to postgresql and sonarqube. In the future better db support will be added.

``Testing``
-----------
1. Install chefDK
	- .. _chefDK: https://downloads.chef.io/chefdk
	- If you get ssl error: gem source -a http://rubygems.org/
2. gem install kitchen-salt kitchen-vagrant
3. kitchen converge

Available states
================

.. contents::
	:local:


``sonarqube``
-------------
Downloads the sonarqube application, extracts is and creates a systemd service named in pillar.
