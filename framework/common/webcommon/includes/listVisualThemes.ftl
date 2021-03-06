<#--
This file is subject to the terms and conditions defined in the
files 'LICENSE' and 'NOTICE', which are part of this source
code package.
-->
<@panel type="callout">${uiLabelMap.CommonVisualThemeUsage}</@panel>

<@section title=uiLabelMap.CommonVisualThemes>
  
  <#if visualThemes?has_content>
    <#assign orderByList = Static["org.ofbiz.base.util.UtilMisc"].toList("visualThemeId")/>
    <@grid>  <#-- tilesType="default" -->
        <#list visualThemes as visualTheme>
        <#assign screenshots = delegator.findByAnd("VisualThemeResource", {"visualThemeId":"${visualTheme.visualThemeId}", "resourceTypeEnumId":"VT_SCREENSHOT"}, orderByList, false)>
            <li <#if visualTheme.visualThemeId == visualThemeId> class="${styles.selected!}"</#if>>
            <form name="SetUserPreferences_${visualTheme.visualThemeId}" method="post" action="<@ofbizUrl>setUserPreference</@ofbizUrl>">
              <input type="hidden" name="userPrefGroupTypeId" value="GLOBAL_PREFERENCES"/>
              <input type="hidden" name="userPrefTypeId" value="VISUAL_THEME"/>
              <input type="hidden" name="userPrefValue" value="${visualTheme.visualThemeId}"/>
            </form>
            <@pul title=visualTheme.visualThemeId!"">
                   <#if screenshots?has_content>
                      <#list screenshots as screenshot>
                        <#-- TODO: <a id="single_image" href="<@ofbizContentUrl>${screenshot.resourceValue}</@ofbizContentUrl>">-->
                        <@img src=makeOfbizContentUrl(screenshot.resourceValue) height="250px" type="contain"/>
                        <#--<span class="${style.text_right}"><@modal icon="${styles.icon} fa-search">
                            <@img src=makeOfbizContentUrl(screenshot.resourceValue)/>
                        </@modal>
                        </span>-->
                        <#--</a>-->
                      </#list>
                   <#else>
                      <@pli>${uiLabelMap.CommonVisualThemeNoScreenshots}</@pli>
                    </#if>

                <@pli type="description">
                    ${visualTheme.get("description", locale)!visualTheme.visualThemeId}
                </@pli>
                <#if visualTheme.visualThemeId == visualThemeId>
                    <@pli type="button">
                        <a href="#" class="${styles.button_default} ${styles.disabled}">${uiLabelMap.CommonSelected}</a>
                    </@pli>
                    <#else>
                    <@pli type="button">
                        <a href="javascript:document.SetUserPreferences_${visualTheme.visualThemeId}.submit()" class="${styles.button_default}">${uiLabelMap.CommonSelect}</a>
                    </@pli>
                </#if>
            </@pul>
          </li>
      </#list>
    </@grid>
      
  </#if>
</@section>