<div id="single-message">
	<g:if test="${messageInstance}">
		<g:hiddenField id="message-src" name="message-src" value="${messageInstance.src}"/>
		<g:hiddenField id="message-id" name="message-id" value="${messageInstance.id}"/>
		<div id='message-info'>
			<p id="message-detail-sender">
				<g:if test="${!messageInstance.inbound && messageInstance.dispatches.size() > 1}">
					<g:remoteLink controller="message" action="showRecipients" params="[messageId: messageInstance.id]" onSuccess="launchSmallPopup('Recipients', data, 'Done', cancel);">
						${messageInstance.displayName}
					</g:remoteLink>
				</g:if>
				<g:else>
					${messageInstance.displayName}
				</g:else>
				<g:if test="${messageInstance.hasFailed && messageInstance.failedCount == 1}"> (failed)</g:if>
				<g:elseif test="${messageInstance.hasFailed && failedDispatchCount}"> (${failedDispatchCount} failed)</g:elseif> 
				<g:if test="${!messageInstance.contactExists}">
					<g:link controller="contact" action="createContact" params="[primaryMobile: ((messageSection == 'sent' || messageSection == 'pending') && messageInstance.dispatches.size() == 1) ? messageInstance.dispatches.dst : messageInstance.src]"><img id="add-contact" src='${resource(dir: 'images/icons', file: 'add.png')}'/></g:link>
				</g:if>
			</p>
			<p id="message-detail-date"><g:formatDate format="dd MMMM, yyyy hh:mm a" date="${messageInstance.date}"/></p>
			<g:if test="${messageInstance.messageOwner && (messageInstance.messageOwner instanceof frontlinesms2.PollResponse)}">
				<p id="message-detail-owner"><g:link action="poll" params="[ownerId: messageInstance.messageOwner.poll.id]">${messageInstance.messageOwner.poll.title} (Poll)</g:link></p>
			</g:if>
			<g:elseif test="${messageInstance.messageOwner && messageInstance.messageOwner instanceof frontlinesms2.Announcement}">
				<p id="message-detail-owner"><g:link action="announcement" params="[ownerId: messageInstance.messageOwner.id]">${messageInstance.messageOwner.name} (Announcement)</g:link></p>
			</g:elseif>
			<g:elseif test="${messageInstance.messageOwner}">
				<p id="message-detail-owner"><g:link action="folder" params="[ownerId: messageInstance.messageOwner.id]">${messageInstance.messageOwner.name} (Folder)</g:link></p>
			</g:elseif>
			<div id="message-detail-content"><p><!-- TODO convert linebreaks in message to new paragraphs (?)  -->${messageInstance.text}</p></div>
		</div>
		<g:if test="${grailsApplication.config.frontlinesms.plugin == 'core'}">
			<g:render template="../message/message_actions" />
			<g:render template="../message/other_actions"/>
		</g:if>
		<g:else>
			<g:render template="/message/message_actions" plugin="core"/>
			<g:render template="/message/other_actions" plugin="core"/>
		</g:else>
	</g:if>
	<g:elseif test="${messageSection == 'trash' && ownerInstance}">
		<div id='message-info'>
			<p id="message-detail-sender">${ownerInstance instanceof frontlinesms2.Poll ? ownerInstance.title : ownerInstance.name} </p>
			<p id="message-detail-date"><g:formatDate format="dd MMMM, yyyy hh:mm a" date="${ownerInstance.dateCreated}"/></p>
			<div id="message-detail-content"><p>${ownerInstance.getLiveMessageCount() == 1 ? "1 message" : ownerInstance.getLiveMessageCount() + " messages"}</p></div>
		</div>
		<g:render template="../message/message_actions"></g:render>
	</g:elseif>
	<g:else>
		<div id='message-info'>
			<g:hiddenField name="viewingArchive" value="${viewingArchive}"></g:hiddenField>
			<div  id="message-detail-content"><p>No message selected</p></div>
		</div>
	</g:else>
</div>
