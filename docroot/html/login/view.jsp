<%--
/**
* tariqliferay.blogspot.com
*/
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/ddm" prefix="liferay-ddm" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>

<%@ page import="com.liferay.portal.CookieNotSupportedException" %>
<%@ page import="com.liferay.portal.NoSuchUserException" %>
<%@ page import="com.liferay.portal.PasswordExpiredException" %>
<%@ page import="com.liferay.portal.UserEmailAddressException" %>
<%@ page import="com.liferay.portal.UserLockoutException" %>
<%@ page import="com.liferay.portal.UserPasswordException" %>
<%@ page import="com.liferay.portal.UserScreenNameException" %>
<%@ page import="com.liferay.portal.kernel.language.LanguageUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ClassResolverUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Constants" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.kernel.util.HtmlUtil" %>
<%@ page import="com.liferay.portal.kernel.util.MethodKey" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.PortalClassInvoker" %>
<%@ page import="com.liferay.portal.kernel.util.PropsUtil" %>
<%@ page import="com.liferay.portal.model.Company" %>
<%@ page import="com.liferay.portal.util.PortalUtil"%>
<%@ page import="com.liferay.portal.util.PortletKeys"%>
<%@ page import="com.liferay.portal.kernel.util.CalendarUtil"%>
<%@ page import="com.liferay.portal.security.auth.AuthException" %>
<%@page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@page import="com.liferay.portlet.PortletURLFactoryUtil"%>

<%@ 
page import="javax.portlet.MimeResponse" %><%@
page import="javax.portlet.PortletConfig" %><%@
page import="javax.portlet.PortletContext" %><%@
page import="javax.portlet.PortletException" %><%@
page import="javax.portlet.PortletMode" %><%@
page import="javax.portlet.PortletPreferences" %><%@
page import="javax.portlet.PortletRequest" %><%@
page import="javax.portlet.PortletResponse" %><%@
page import="javax.portlet.PortletURL" %><%@
page import="javax.portlet.ResourceURL" %><%@
page import="javax.portlet.UnavailableException" %><%@
page import="javax.portlet.ValidatorException" %><%@
page import="javax.portlet.WindowState" %><%@
page import="java.util.*" %><%@ 
page import="java.text.*" %><%@ 
page contentType="text/html; charset=UTF-8" %>

<portlet:defineObjects />
<liferay-theme:defineObjects />

<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.min.js"></script> 

<portlet:actionURL var="customloginURL" name="customlogin"/>

<liferay-ui:error key="authentication-failed"  message="authentication-failed"/>  

<c:set var="isSign" value="<%= themeDisplay.isSignedIn() %>"/>

<c:choose>
<c:when test="<%= themeDisplay.isSignedIn() %>">
	<%
	String signedInAs = user.getFullName();
	if (themeDisplay.isShowMyAccountIcon()) {
	signedInAs = "<a href=\"" + themeDisplay.getURLMyAccount().toString() + "\">" + signedInAs + "</a>";
	}
	%>

</c:when>
<c:otherwise>
	<%
	MethodKey methodKey = new MethodKey(ClassResolverUtil.resolveByPortalClassLoader("com.liferay.portlet.login.util.LoginUtil"), "getLogin", HttpServletRequest.class, String.class, Company.class);
	String login = GetterUtil.getString((String)PortalClassInvoker.invoke(false, methodKey, request, "login", company));
	boolean rememberMe = ParamUtil.getBoolean(request, "rememberMe");
	%>
	
	<aui:form action="<%= customloginURL %>" method="post" name="signinform" cssClass="form-signin" id="signinform">
		<aui:input name="saveLastPath" type="hidden" value="<%= false %>" />
		<aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />
		<aui:input name="rememberMe" type="hidden" value="<%= rememberMe %>" />
		<liferay-ui:error exception="<%= AuthException.class %>" message="authentication-failed" />
		<liferay-ui:error exception="<%= CookieNotSupportedException.class %>" message="authentication-failed-please-enable-browser-cookies" />
		<liferay-ui:error exception="<%= NoSuchUserException.class %>" message="please-enter-a-valid-login" />
		<liferay-ui:error exception="<%= PasswordExpiredException.class %>" message="your-password-has-expired" />
		<liferay-ui:error exception="<%= UserEmailAddressException.class %>" message="please-enter-a-valid-login" />
		<liferay-ui:error exception="<%= UserLockoutException.class %>" message="this-account-has-been-locked" />
		<liferay-ui:error exception="<%= UserPasswordException.class %>" message="please-enter-a-valid-password" />
		<liferay-ui:error exception="<%= UserScreenNameException.class %>" message="please-enter-a-valid-screen-name" />
        <input type="text" name="<portlet:namespace/>login" class="input-block-level" placeholder="<liferay-ui:message key="your-email-address" />" required>
        <input type="password" name="<portlet:namespace/>password" class="input-block-level signpwd" placeholder="<liferay-ui:message key="your-password" />" required>
        
	    <br/>
		<a onclick="document.getElementById('<portlet:namespace/>signinform').submit();" class="parent" href="#">
			<div class="child1">
				<span class="pull-right" style="padding-top: 7px;color: #bd1e51;text-decoration: none; "><liferay-ui:message key="sign-in"/></span>
			</div>
		</a> 
		<br/>
	</aui:form>

</c:otherwise>
</c:choose>

<style type="text/css">
      body {
        padding-top: 40px;
        padding-bottom: 40px;
        background-color: #f5f5f5;
      }

      .form-signin {
        max-width: 300px;
        padding: 19px 29px 29px;
        margin: 0 auto 20px;
        background-color: #fff;
      }
      .form-signin .form-signin-heading,
      .form-signin .checkbox {
        margin-bottom: 10px;
      }
      .form-signin input[type="text"], .form-signin input[type="password"] {
		font-size: 16px;
		height: auto;
		padding: 7px 9px;
		border: none;
		background: #F0F0F0;
		margin: 0;
	  }
	  .signpwd {
		border-top: 1px solid #A3A3A3 !important;
		margin-bottom: 20px !important;
	  }
	  .form-signin h2.form-signin-heading {
		font-size: 25px;
		margin-bottom: 20px;
		text-transform: uppercase;
	  }
	  
	  .container-fluid a, .container-fluid a:HOVER, .lfr-discussion-posted-on a, .lfr-discussion-posted-on a:HOVER{
		color: #bd1e51;
		text-decoration: none;
	 }

    </style>
    
<script type="text/javascript">

	$("input").keypress(function(event) {
	    if (event.which == 13) {
	        event.preventDefault();
	        document.getElementById('<portlet:namespace/>signinform').submit();
	    }
	});
	
</script>


