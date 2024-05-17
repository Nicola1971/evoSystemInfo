//<?php
/**
 * evoSystemInfo
 *
 * Snippet displaying EVO system info and some actions on the frontend.
 *
 * @category    snippet
 * @version     1.3
 * @license     http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal    @modx_category Content
 * @internal    @installset base, sample
 * @author      Piotr Matysiak (https://github.com/pmfx)
 */

// evoSystemInfo 1.3
// Snippet displaying EVO system info and some actions on the frontend.
// Call it uncached [!evoSystemInfo!] before </body> tag in your template.
// Dark theme: [!evoSystemInfo? &theme=`dark`!] (EVO 1.4.4 or later required)
// author: Piotr Matysiak webready.pl
	
if ( isset($_SESSION['mgrValidated']) ) {
	$docId = $modx->documentIdentifier;
	$docTemplateId   = $modx->documentObject['template'];
	$docTemplateName = $modx->db->getValue( $modx->db->select( 'templatename', $modx->getFullTableName('site_templates'), 'id='.$docTemplateId ));
	
	$docEditedon = $modx->getDocumentObject('id',$docId);
	$docEditedon = $docEditedon['editedon'];
	$docEditedon = strftime('%y.%m.%d %H:%M:%S',$docEditedon);
	
	$docEditedby = $modx->getDocumentObject('id',$docId);
	$docEditedby = $docEditedby['editedby'];
	$docEditedby = $modx->getUserInfo($docEditedby);
	$docEditedby = $docEditedby['username'];
	
	if ($theme == 'dark') {
		$logo = 'logo-navbar-left-white.png';
	} else {
		$logo = 'logo.png';
	}
	
	$css = '
	<style>
		body {
			padding-bottom: 52px !important;
		}
		.evo-system-section {
			position: fixed;
			bottom: 0;
			left: 0;
			right: 0;
			z-index: 10000;
			margin-top: 15px;
			padding-top: 12px;
			padding-bottom: 12px;
			padding-left: 50px;
			color: #aaa;
			border-style: solid;
			border-color: #ddd;
			border-width: 1px;
			background-color: #fafafa;
			box-shadow: 0 0 5px 0 rgba(0,0,0,0.1);
			font-size: 11px;
			font-family: Helvetica,Arial,sans-serif;
			text-transform: uppercase;
			overflow: hidden;
			width: 65px;
			height: 53px;
		}
		.evo-system-section:hover {
			right: 0;
			width: auto;
		}
		.evo-system-section__container {
			margin-right: auto;
			margin-left: auto;
			padding-left: 15px;
			padding-right: 15px;
		}
		.evo-system-section__logo {
			position: absolute;
			top: 9px;
			left: 15px;
			width: 35px;
		}
		.evo-system-section__actions {
			display: inline-block;
			margin-right: 15px;
		}
		.evo-system-section__action {
			display: inline-block;
			margin-right: 5px;
			font-size: 13px;
			font-weight: bold;
			color: #777;
			border: 1px solid #ddd !important;
			border-radius: 3px;
			padding: 4px 8px;
			background-color: #fff !important;
		}
		.evo-system-section__action:hover,
		.evo-system-section__action:active,
		.evo-system-section__action:focus {
			text-decoration: none;
		}
		.evo-system-section__action:hover {
			color: #333 !important;
			background-color: rgba(0,0,0,0.025) !important;
		}
		.evo-system-section__list {
			display: inline-block;
			list-style: none;
			margin: 0;
			float: right;
			padding: 0;
			padding-top: 7px;
		}
		.evo-system-section__item {
			display: inline-block;
			margin-right: 10px;
		}
		.evo-system-section__item,
		.evo-system-section__item .type,
		.evo-system-section__item .value {

		}
		.evo-system-section__item .value,
		.evo-system-section__item .value a {
			text-transform: none;
			color: #777;
		}
		
		/* theme: dark */
		
		.evo-system-section.dark {
			border-width: 0;
			background-color: #343944;
		}
		.evo-system-section.dark,
		.evo-system-section.dark .evo-system-section__action {
			color: #c9c9c9 !important;
		}
		.evo-system-section.dark .evo-system-section__action {
			border-color: rgba(255,255,255,0.4) !important;
			background-color: rgba(255,255,255,0.1) !important;
		}
		.evo-system-section.dark .evo-system-section__action:hover {
			color: #ddd !important;
			background-color: rgba(255,255,255,0.2) !important;
		}
		.evo-system-section.dark .evo-system-section__item .value, 
		.evo-system-section.dark .evo-system-section__item .value a {
			color: #aaa;
		}
	</style>
	';

	$html = '
	<div class="evo-system-section '.$theme.'">
		<div class="evo-system-section__container">
			<img class="evo-system-section__logo" src="[(site_url)]manager/media/style/default/images/misc/' . $logo . '" alt="EVO">
			<div class="evo-system-section__actions">
				<a class="evo-system-section__action" target="_blank" href="[(site_url)]manager/index.php?a=27&id=[*id*]" target="EvoSysInfoResourceEdit" onclick="openEvoSysInfoResourceEdit(); return false;">Edit page</a>
				<a class="evo-system-section__action" target="_blank" href="[(site_url)]manager/">Manager</a>
				<a class="evo-system-section__action" href="[(site_url)]manager/index.php?a=8">Logout</a>
			</div>
			<ul class="evo-system-section__list">
				<li class="evo-system-section__item"><span class="type">Edited:</span> <span class="value"><a target="_blank" href="[(site_url)]manager/index.php?a=3&id=' . $docId . '&tab=0" target="EvoSysInfoResourceOverview" onclick="openEvoSysInfoResourceOverview(); return false;" title="Last edited by ' . $docEditedby . '">' . $docEditedon . ' (' . $docEditedby . ')</a></span></li>
				<li class="evo-system-section__item"><span class="type">ID:</span> <span class="value">[*id*]</span></li>
				<li class="evo-system-section__item"><span class="type">Template:</span> <span class="value"><a target="_blank" href="[(site_url)]manager/index.php?a=16&id=' . $docTemplateId . '" target="EvoSysInfoTemplateEdit" onclick="openEvoSysInfoTemplateEdit(); return false;" title="Edit ' . $docTemplateName . ' template">' . $docTemplateName . '</a></span></li>
				<li class="evo-system-section__item"><span class="type">Source:</span>   <span class="value">[^s^]</span></li>
				<li class="evo-system-section__item"><span class="type"><abbr title="Including 4 evoSystemInfo snippet queries">Queries</abbr>:</span>  <span class="value">[^q^]</span></li>
				<li class="evo-system-section__item"><span class="type"><abbr title="Query T: [^qt^], Parse T: [^p^], Total T: [^t^]">Time</abbr>:</span>   <span class="value">[^t^]</span></li>
			</ul>
		</div>
	</div>
	';
	
	$js = '
	<script type="text/javascript">
		var windowObjectReference = null;

		function openEvoSysInfoResourceEdit() {
			if(windowObjectReference == null || windowObjectReference.closed)
			{
				windowObjectReference = window.open("[(site_url)]manager/index.php?a=27&id=[*id*]",
				"EvoSysInfoResourceEdit", 
				"resizable,scrollbars,status,width=900,height=800");
			}
			else
			{
				windowObjectReference.focus();
			};
		}

		function openEvoSysInfoResourceOverview() {
			if(windowObjectReference == null || windowObjectReference.closed)
			{
				windowObjectReference = window.open("[(site_url)]manager/index.php?a=3&id=' . $docId . '&tab=0",
				"EvoSysInfoResourceOverview", 
				"resizable,scrollbars,status,width=900,height=800");
			}
			else
			{
				windowObjectReference.focus();
			};
		}

		function openEvoSysInfoTemplateEdit() {
			if(windowObjectReference == null || windowObjectReference.closed)
			{
				windowObjectReference = window.open("[(site_url)]manager/index.php?a=16&id=' . $docTemplateId . '",
				"EvoSysInfoTemplateEdit", 
				"resizable,scrollbars,status,width=900,height=800");
			}
			else
			{
				windowObjectReference.focus();
			};
		}
	</script>
	';

	$output = $css.$html.$js;

	return $output;
}