package com.boot.finalpro.configuration.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;

import com.boot.finalpro.security.CustomLoginSuccessHandler;
import com.boot.finalpro.security.CustomLogoutSuccessHandler;
import com.boot.finalpro.security.CustomUserDetailesSerivce;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

	/**유저 정보를 가져올 곳과 비밀번호 암호화 알고리즘 설정
	 *
	 */
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService( customUserService() ).passwordEncoder( bCryptPasswordEncoder() );
	}

	/**security를 무시하는 패턴 설정.
	 *
	 */
	@Override
	public void configure(WebSecurity web) throws Exception {
		//web.ignoring().antMatchers("/common/api/idcheck/isusable", "/favicon.ico", "/css/**", "/image/**", "/js/**", "/webjars/**", "/vendor/**");
		web.ignoring().antMatchers("/favicon.ico", "/css/**", "/image/**", "/js/**", "/webjars/**", "/vendor/**");
	}

	/**URI 별 접근권한, 로그인 페이지, 로그아웃 등 전체적인 설정
	 *
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		log.info("HttpSecurity");
		//URI패턴 별 권한 설정
		http
			.authorizeRequests()
				.antMatchers("/common/**").permitAll()
				.antMatchers("/admin/**").access("hasRole('ROLE_ADMIN')")
				.antMatchers("/member/**").access("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN','ROLE_TEAMLEADER','ROLE_TEAMMEMBER')")
				.antMatchers("/mypage/**").access("hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN','ROLE_TEAMLEADER','ROLE_TEAMMEMBER')");				
		//로그인페이지 설정
		http
			.formLogin()
				.loginPage("/common/loginPage.do").permitAll()
				.loginProcessingUrl("/login")
				.successHandler( loginSuccessHandler() );
		//로그아웃 관련 설정
		http
			.logout()
				.logoutUrl("/logout")
				.invalidateHttpSession(true)
				.deleteCookies("remember-me", "JSESSION_ID")
				.logoutSuccessHandler( logoutSuccessHandler() );
		//ck 에디터 관련 설정
		 http
         .headers()
            .frameOptions()
               .sameOrigin();
		 // 403 에러 
		 http
		 .exceptionHandling()
		 	// 권한이 없는 페이지 접속시 보내주는 Denied페이지
		 	.accessDeniedPage("/common/deniedPage.do");
		 http
		 // 최대 세션 접근수
		 .sessionManagement().maximumSessions(1)
		 // 해당세션 재접근 차단여부 true 시 이미 로그인한 아이디로 재로그인시 에러발생
		 .maxSessionsPreventsLogin(true)
		 // 중복아이디 로그인시 보내주는 url
		 .expiredUrl("/loginPage.do");
		
	}

	/**로그인에 성공한 경우 후속 작업을 설정한 핸들러를 리턴
	 * @return
	 */
	@Bean
	public AuthenticationSuccessHandler loginSuccessHandler() {
		return new CustomLoginSuccessHandler();
	}

	/**로그아웃에 성공한 경우 후속 작업을 설정한 핸들러를 리턴
	 * @return
	 */
	@Bean
	public LogoutSuccessHandler logoutSuccessHandler() {
		return new CustomLogoutSuccessHandler();
	}
	/**http session event publisher 리턴
	 * @return
	 */
	@Bean
	public HttpSessionEventPublisher httpSessionEventPublisher() {
		return new HttpSessionEventPublisher();
	}
	
	/**비밀번호를 암호화하기 위한 인코더 리턴
	 * @return
	 */
	@Bean
	public BCryptPasswordEncoder bCryptPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	/**DB에 저장된 사용자 정보를 가져오기 위함
	 * @return
	 */
	@Bean
	public UserDetailsService customUserService() {
		return new CustomUserDetailesSerivce();
	}
}
