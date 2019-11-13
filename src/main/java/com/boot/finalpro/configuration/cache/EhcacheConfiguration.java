package com.boot.finalpro.configuration.cache;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Configuration;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
@EnableCaching
public class EhcacheConfiguration implements CommandLineRunner{

	@Autowired
	private CacheManager cacheManager;
	
	@Override
	public void run(String... args) throws Exception {
		 log.info("\n\n" + "====================================================================================\n"
	                + "Using cache manager: " + this.cacheManager.getClass().getName() + "\n"
	                + "====================================================================================\n\n");
	}

}
