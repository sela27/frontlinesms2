<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta name="layout" content="settings" />
		<title><g:message code="connection.header" /> ${connectionInstance?.name}</title>
		<g:if test="${params.createRoute}">
			<g:javascript>
				$(function() {
					var connectionTimer = setInterval(refreshConnectionStatus, 2000);
					function refreshConnectionStatus() {
						$.get("${createLink(controller:'connection', action:'list', id:params?.id)}", function(data) {
								$("#connections").replaceWith($(data).find('#connections'));
						});
					}
			});
			</g:javascript>
		</g:if>
	</head>
	<body>
		<g:render template="/connection/connection_list"/>
	</body>
</html>