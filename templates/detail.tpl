<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"  lang="en" xml:lang="en">
  <head>
    <meta charset="utf-8"/>
%if alt_title:
  %if not name:
    <title>{{alt_title}} - {{type_epsg}}:{{code_short[0]}}</title>
  %else:
    <title>{{name}} - {{alt_title}} - {{type_epsg}}:{{code_short[0]}}</title>
  %end
%else:
  %if not name:
    <title>{{type_epsg}}:{{code_short[0]}}</title>
  %else:
    <title>{{name}} - {{type_epsg}}:{{code_short[0]}}</title>
  %end
%end

    <meta content="width=device-width, initial-scale=1, maximum-scale=1" name="viewport" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  %if item['area'] !="" or item['remarks'] !="" or item['scope']!="":
    <meta name="description" content="EPSG:{{code_short[0]}} {{kind}} for {{item['area']}} {{item['remarks']}} {{item['scope']}}" />
  %else:
    <meta name="description" content="EPSG:{{code_short[0]}} {{kind}}"/>
  %end
    %if not url_static_map[1]:
    <meta property="og:image" content="//epsg.io/img/epsg-banner-440x280-2.png"/>
    %end
    <meta name="keywords" content="EPSG.io" />
    <meta name="robots" content="ALL,FOLLOW" />
    <link rel="stylesheet" href="/css/main.css" type="text/css" />
    <link rel="shortcut icon" href="//epsg.io/favicon.ico" />
    <script src="/js/ZeroClipboard.min.js"></script>
    <script src="/js/index.js"></script>
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','__gaTracker');

      __gaTracker('create', 'UA-47718358-1', 'epsg.io');
      __gaTracker('send', 'pageview');
    </script>

  </head>

  <body id="detailpage" data-role="page">

    <div id="head">
      <p id="logo-container">
        <a href="/" title=""><span>Pacific Projections</span> Pacific Coordinate Systems</a>
      </p>
      <ul id="menu-top">
        <li><a href="/map" title="">Map</a></li>
        <li><a href="/transform" title="">Transform</a></li>
        <li><a href="/about" title="">About</a></li>
      </ul>
    </div>

    <div id="layout-container">
      <div id="title_kind">
        <div class="title-right">
        <!-- 
        <div class="socialicons">
          <a id="share_facebook" href="https://www.facebook.com/sharer/sharer.php?u=//epsg.io/{{url_social}}"><span class="icon-epsg-facebook"></span></a>
          <a id="share_twitterb" href="https://twitter.com/share?original_referer=//epsg.io/{{url_social}}&amp;text={{name}} - {{type_epsg}}:{{code_short[0]}}&amp;"><span class="icon-epsg-twiter"></span></a>
          %if url_static_map[0]:
          <a id="share_pinterest" href="https://pinterest.com/pin/create/button/?url=%2F%2Fepsg.io/{{url_social}}&amp;media={{url_static_map[0]}}"><span class="icon-epsg-pinterest"></span></a>
          %else:
          <a id="share_pinterest" href="https://pinterest.com/pin/create/button/?url=%2F%2Fepsg.io/{{url_social}}&amp;media=http%3A%2F%2Fepsg.io%2Fimg%2Fepsg-banner-440x280-2.png"><span class="icon-epsg-pinterest"></span></a>
          %end
          <a id="share_gplusdark" href="https://plus.google.com/share?url=//epsg.io/{{url_social}}"><span class="icon-epsg-googleplus"></span></a>
        </div>
        -->
        
        <div class="detail-action-buttons">
          <a class="btn" href="/transform#s_srs={{url_social}}" title="Transform {{name}} -- {{alt_title}} coordinates">
              Transform&nbsp;coordinates</a>
            <a class="btn" href="/map#srs={{url_social}}"  title="Display {{name}} -- {{alt_title}} on a map">
              Get&nbsp;position&nbsp;on&nbsp;a&nbsp;map</a>
        </div>
        </div>
      %if item['deprecated'] == 1 or item['deprecated'] == "true" :
        <h1>{{type_epsg}}:{{code_short[0]}} DEPRECATED</h1>
      %else:
        <h1>{{type_epsg}}:{{code_short[0]}}</h1>
      %end

      <p>
        {{kind}}
      </p>

      %if alt_title:
      <h2>{{name}} -- {{alt_title}}</h2>
      %else:
      <h2>{{name}}</h2>
      %end
      </div>
      %found_trans = False
      %if trans != [] or (center and trans_lat) or (detail !=[] and detail[0]['url_area']!="/?q=") or (item['kind']=="PRIMEM" or item['kind']=="AXIS") or item['data_source']:
      <div id="detail-content-container">
        <div class="covered-area-container">
          <div class="cac-inner">
            %no_map = False
            %if item['bbox']:
            <h3 class="underline-style">Covered area</h3>

              %if center:
                %if trans_lat:
                  <div id="mini-map">
                    <a href="{{url_format}}/map">
                      <img src="/img/epsg-target-small.png" id="crosshair" alt="" />
                        <img src="{{url_static_map[1]}}" alt="SimpleMap" width="265" height="215">

                    </a>
                  </div>
                %else:
                  <div id="mini-map">
                    <img src="/img/epsg-target-small.png" id="crosshair" alt="" />
                      <img src="{{url_static_map[1]}}" alt="SimpleMap" width="265" height="215">
                  </div>
                %end
              %end
            %else:
              %no_map = True
            %end

            %wgs_found = False

            %if trans_lat and trans_lon:
              <p>
                <span class="caption">Center coordinates</span><br />
                <span>{{trans_lat}}</span>  <span>{{trans_lon}}</span> <br />
                %if item['kind'] != "CRS-GEOGCRS":
                  %wgs_found = True
                  <p>
                    <span class="caption">Projected bounds:</span><br />
                    {{bbox_coords[3]}} {{bbox_coords[2]}}<br />
                    {{bbox_coords[1]}} {{bbox_coords[0]}}<br />
                  </p>
                %end
                <p>
                  %if default_trans:
                    %wgs_found = True

                    <span class="caption">WGS84 bounds:</span><br />
                    {{default_trans['bbox'][1]}} {{default_trans['bbox'][2]}}<br />
                    {{default_trans['bbox'][3]}} {{default_trans['bbox'][0]}}
                  %else:
                    %wgs_found = True
                    <span class="caption">WGS84 bounds:</span><br />
                    {{item['bbox'][1]}} {{item['bbox'][2]}}<br />
                    {{item['bbox'][3]}} {{item['bbox'][0]}}
                  %end

                </p>
              </p>
            %end

            %if bbox_coords and not (trans_lat or trans_lon) and bbox_coords != ("","","",""):
            <p>
            <span class="caption">WGS84 bounds:</span><br />
            {{bbox_coords[1]}} {{bbox_coords[2]}}<br />
            {{bbox_coords[3]}} {{bbox_coords[0]}}
            </p>
            %elif item['bbox'] and not wgs_found:
            <p>
            <span class="caption">WGS84 bounds:</span><br />
            {{item['bbox'][1]}} {{item['bbox'][2]}}<br />
            {{item['bbox'][3]}} {{item['bbox'][0]}}
            </p>
            %end
          </div>
          <div class="cac-inner">

            %if default_trans:
              <a href="{{url_area_trans}}">{{default_trans['area']}}</a>
            %elif item['area'] and (url_area):
              <a href="{{url_area}}">{{item['area']}}</a>
            %end

            %found_trans = False
            %if item['kind'].startswith("COORDOP"):
            <p></p>
              %found_trans = True
              <div id="projected-link-trans">
                  %if projcrs_by_gcrs:

                      <h3 class="underline-style">Coordinates on a map</h3>
                  %end

                  %for r in projcrs_by_gcrs:
                    <a href="/{{r['result']['code']}}/map"><span class="caption">{{r['result']['name']}}</span></a>

                     code <a href="{{r['result']['code']}}">{{r['result']['code']}}</a><br />
                  %end

                  %if more_gcrs_result:
                    <a href="{{more_gcrs_result}}">More</a>
                  %end
              </div>
            %end
          </div>
        </div>
        <div class="detail-content-inner-wide">
          <div class="transformations-container">
              %no_trans = False
              %if trans:
                <h3 class="underline-style">Available transformations:</h3>
                <div class="transformations-container-inner">
                  <ul>
                    % i = 0
                    %for r in trans:
                      %if r['link'] == "" and r['deprecated'] == 0:
                        <li><i></i>

                         <span class="caption">{{r['area_trans_trans']}}</span>

                        %if r['accuracy']:
                          , accuracy&nbsp;{{r['accuracy']}}&nbsp;m,
                        %end

                        %if r['code_trans'] != 0:
                          code&nbsp;{{r['code_trans']}}
                        %end

                        %if r['default'] == True:
                          <em>(default)</em>
                        %end
                        %if r['num_param']:
                          [{{r['num_param']}}]
                        %end

                        % i +=1
                        </li>

                      %elif r['deprecated'] == 0:
                        <li>


                          <a href="/{{r['link']}}" title = "{{r['trans_remarks']}}">
                            <span class="caption">{{r['area_trans_trans']}}</span>, accuracy&nbsp;{{r['accuracy']}}&nbsp;m, code&nbsp;{{r['code_trans']}}
                            %if r['default'] == True:
                              <em>(default)</em>
                            %end
                            %if r['num_param']:
                              [{{r['num_param']}}]
                            %end
                          </a>
                          %i+=1

                        </li>
                      %end
                    %end

                  %if deprecated_available == 1:
                    %if i == 0:
                      <p></p>

                      <div id="trans_deprecated">
                    %else:
                    <p></p>

                      <a href="#" id="trans_deprecated_link">Show deprecated transformations</a>
                      <div id="trans_deprecated">
                    %end

                    %for r in trans:
                      %if r['deprecated'] == 1:
                        %if r['link'] == "":
                          <li><i></i>
                            %if r['default'] == True:
                              <span class="caption"><em>(default)</em></span>
                            %end
                            <span class="caption">{{r['area_trans']}}</span>, accuracy&nbsp;{{r['accuracy']}}&nbsp;m, code&nbsp;{{r['area_trans_trans']}} <em>(deprecated)</em>
                            %if r['num_param']:
                              [{{r['num_param']}}]
                            %end
                          </li>
                        %else:
                          <li>
                            %if r['default'] == True:
                              <span class="caption"><em>(default)</em></span>
                            %end
                            <a href="/{{r['link']}}" title = "{{r['trans_remarks']}}"><span class="caption">{{r['area_trans_trans']}}</span>, accuracy&nbsp;{{r['accuracy']}}&nbsp;m, code&nbsp;{{r['code_trans']}} <em>(deprecated)</em>
                            %if r['num_param']:
                              [{{r['num_param']}}]
                            %end

                            </a>
                          </li>
                        %end
                      %end
                    %end
                    </div><p></p>

                  %end
                  </ul>

                </div>
              </div>
              %else:
              </div>
                %no_trans = True
                %if 'alt_description' in item:
                  %if item['alt_description']:
                    %if wkt:
                      <p>
                        <div id="description-message">{{!item['alt_description']}}</div></p>
                    %else:
                      %if export_html:
                        <div id="description-message">{{!export_html}} </div>
                      %else:
                        <div id="description-message">{{!item['alt_description']}} </div>
                      %end
                    %end
                  %end
                %end

                %if 'alt_code' in item:
                  %if item['alt_code'] != ['']:
                  <p>
                    <span class="caption">Alternatives codes : </span>
                    %for a in item['alt_code']:
                      <a href="/{{a}}">{{a}}</a>
                    %end
                  </p>
                  %end
                %end
              %end

          %if trans:
          <div class="location-data-container">
            %found = False
            <h3 class="underline-style">Selected transformation</h3>
              %for r in trans:
                %if r['link'] == "" and not found:
                  %found = True
                  <h2>
                    {{r['area_trans_trans']}}
                  </h2>
                  %if r['code_trans'] != 0:
                    code <a href="/{{r['code_trans']}}">{{r['code_trans']}}</a>
                  %end
                  <p><p></p>
                  %if r['accuracy']:
                    Accuracy&nbsp;{{r['accuracy']}}&nbsp;m
                  %end

                  %if r['default'] == True:
                    (default)
                  %end
                  <br />
                  %if r['num_param'] != "grid" and r['num_param']:
                    {{r['num_param']}} parameters
                  %elif r['num_param'] == "grid":
                    grid file
                  %end
                  </p>
                %end
              %end

            %no_default = False
            %if not found:
              %no_default = True
              %if not no_trans:
                <p>NO DEFAULT TRANSFORMATION</p>
              %end
            %end

            %if trans and default_trans:
              <div class="attributes">
                %if default_trans['method']:
                  <p><span class="caption">Method: </span><a href="/{{default_trans['method'][0]}}-method">{{default_trans['method'][1]}}</a></p>
                %end
                  <p><span class="caption">Remarks: </span>{{default_trans['remarks']}}</p>
                  <p><span class="caption">Information source: </span>{{default_trans['information_source']}}</p>
                  <p><span class="caption">Revision date: </span>{{default_trans['revision_date']}}</p>

                %if url_concatop != []:
                  <p>
                    <span class="caption">Steps of transformation: </span>
                    %for url in url_concatop:
                      <a href="{{url}}">{{url}} </a>
                    %end
                  </p>
                %end
              </div>
            %end


          </div>

          %end
          <div class="clnr"></div>

          <h3 class="underline-style">Attributes</h3>
          <div class="attributes-col">
            %if 'uom_code' in item:
              %if item['uom_code']:
                <p><span class="caption">Unit: </span>{{item['uom']}}</p>
              %end
            %end

            %if 'geogcrs' in item:
              %if item['geogcrs']:
                <p><span class="caption">Geodetic CRS: </span><a href="/{{item['geogcrs'][0]}}">{{item['geogcrs'][1]}}</a></p>
              %end
            %end

            %if 'datum' in item:
              %if item['datum'] != 0 and item['datum'] :
                <p><span class="caption">Datum: </span><a href="/{{item['datum'][0]}}-datum/">{{item['datum'][1]}}</a></p>
              %end
            %end

            %if 'ellipsoid' in item:
              %if item['ellipsoid']:
                %if item['ellipsoid'][0] != "None":
                  <p><span class="caption">Ellipsoid: </span><a href="/{{item['ellipsoid'][0]}}-ellipsoid">{{item['ellipsoid'][1]}}</a></p>
                %end
              %end
            %end

            %gl = False
            %if 'primem' in item:
              %if item['primem']:
                <p>
                  <span class="caption">Prime meridian: </span><a href="/{{item['primem'][0]}}-primem">{{item['primem'][1]}}</a>
                  %if 'greenwich_longitude' in item:
                    %if int(item['primem'][0]) != 8901 and str(greenwich_longitude) != str(361):
                      ({{greenwich_longitude}} degree from Greenwich)
                      %gl = True
                    %end
                  %end
              %end
            %end

            %if detail != [] and not gl:
              %if 'greenwich_longitude' in item:
                %if item['greenwich_longitude'] != 0 and item['greenwich_longitude'] and str(greenwich_longitude) != str(361):
                 <p><span class="caption">Degree from Greenwich: </span>{{greenwich_longitude}}</p>
                %end
              %end
            %end

            %if 'data_source' in item:
              %if item['data_source']:
                <p><span class="caption">Data source: </span>{{item['data_source']}} </p>
              %end
            %end

            %if 'information_source' in item:
              %if item['information_source']:
                <p><span class="caption">Information source: </span>{{item['information_source']}}</p>
              %end
            %end

            %if 'revision_date' in item:
              %if item['revision_date']:
                <p><span class="caption">Revision date:  </span>{{item['revision_date']}}</p>
              %end
            %end

            %if url_concatop != []:
              <p>
                <span class="caption">Steps of transformation: </span>
                %for url in url_concatop:
                  <a href="{{url}}">{{url}} </a>
                %end
              </p>
            %end

            %if nadgrid:
            <p><span class="caption">NadGrid file: </span>{{nadgrid}}</p>
            %end

            %if item['target_uom']:
              %if int(code_short[0]) != int(item['target_uom'][0]):
                <p><span class="caption">Target unit: </span><a href="/{{item['target_uom'][0]}}-units">{{item['target_uom'][1]}}</a></p>
              %end
            %end

            %if item['files']:
              <p><span class="caption">File: </span>{{item['files']}}</p>
            %end


            %if item['orientation']:
              <p><span class="caption">Orientation: </span>{{item['orientation']}}</p>
            %end

            %if item['abbreviation']:
              <p><span class="caption">Abbreviation: </span>{{item['abbreviation']}}</p>
            %end

            %if item['order']:
              <p><span class="caption">Axis order: </span>{{item['order']}}.</p>
            %end

            %if detail != []:
              %if detail[0]['url_axis']:
                %for a in detail[0]['url_axis']:
                  <p><span class="caption">Link to axis : </span><a href="/{{a['axis_code']}}-axis">{{a['axis_name']}}</a></p>
                %end
              %end
            %end

          </div>

          <div class="attributes-col2">

            %if 'scope' in item:
              %if item['scope']:
              <p>
                <span class="caption">Scope: </span>{{item['scope']}}
              </p>
              %end
            %end

            %if 'remarks' in item:
              %if item['remarks']:
              <p>
                <span class="caption">Remarks: </span>{{item['remarks']}}
              </p>
              %end
            %end

            %if "method" in item:
              %if item['method']:
                <p><span class="caption">Method: </span><a href="/{{item['method'][0]}}-method" title="">{{item['method'][1]}}</a></p>
              %end
            %end

             %if detail:
              %if detail[0]['url_area'] != "" and detail[0]['url_area'] != "/?q=" and item['kind'] != "AREA":
                <p>
                  <span class="caption">Area of use: </span><a href="{{detail[0]['url_area']}}"> {{item['area']}}</a>
                </p>
              %end
            %else:
              %if item['area'] != "":
                <p>
                 <span class="caption">Area of use: </span><a href="{{url_area}}">{{area_item}}</a>
                </p>
              %end
            %end

            %if 'cs' in item:
              %if item['cs']:
                <p>
                  <span class="caption">Coordinate system: </span><a href="/{{item['cs'][0]}}-cs">{{item['cs'][1]}}</a>
                </p>
              %end
            %end

            %if 'description' in item:
              %if item['description']:
                <p><span class="caption">Description: </span>{{item['description']}}</p>
              %end
            %end

          </div>

        </div>



      </div>
      %else:
        %if 'alt_description' in item:
          %if item['alt_description']:
            <div id="description-message">{{!item['alt_description']}}</div>
          %end
        %end
        %if 'alt_code' in item:
          %if item['alt_code'] != ['']:
          <p>
            <span class="caption">Alternatives codes : </span>
            %for a in item['alt_code']:
              <a href="/{{a}}">{{a}}</a>
            %end
          </p>
          %end
        %end
      %end

      <div id="edit-box-container">
        %if url_format and error_code == 0:
        <div id="eb-menu-container">
          <h4>Export</h4>
          <ul id="eb-menu">
            <li><a class="switcher switcher_selected" id="s_html" href="{{url_format}}.html">Well Known Text as HTML<i></i></a></li>
            <li><a class="switcher" id="s_wkt" href="{{url_format}}.wkt">OGC WKT<i></i></a></li>
            <li><a class="switcher" id="s_esriwkt" href="{{url_format}}.esriwkt">ESRI WKT<i></i></a></li>

            <!-- <li><a class="switcher" id="s_prettywkt" href="{{url_format}}.prettywkt">PrettyWKT<i></i></a></li>-->
            %if ogpxml != "":
              <li><a class="switcher" id="s_gml" href="{{url_format}}.gml">OGC GML<i></i></a></li>
            %end
            %if export['xml'] != "":
              <li><a class="switcher" id="s_xml" href="{{url_format}}.xml">XML<i></i></a></li>
            %end
            <li><a class="switcher" id="s_proj4" href="{{url_format}}.proj4">PROJ.4<i></i></a></li>
            <li><a class="switcher" id="s_proj4js" href="{{url_format}}.proj4js">Proj4js<i></i></a></li>
            %if export['usgs'] != "":
              <li><a class="switcher" id="s_usgs" href="{{url_format}}.usgs">USGS<i></i></a></li>
            %end
            <li><a class="switcher" id="s_geoserver" href="{{url_format}}.geoserver">GeoServer<i></i></a></li>
            <li><a class="switcher" id="s_mapfile" href="{{url_format}}.mapfile">MapServer<i></i></a></li>
            <!-- <li><a class="switcher" id="s_mapserverpython" href="{{url_format}}.mapserverpython">MapSever - Python<i></i></a></li> -->
            <li><a class="switcher" id="s_mapnik" href="{{url_format}}.mapnik">Mapnik<i></i></a></li>
            <!-- <li><a class="switcher" id="s_mapnikpython" href="{{url_format}}.mapnikpython">Mapnik - Python<i></i></a></li> -->
            <li><a class="switcher" id="s_postgis" href="{{url_format}}.sql">PostGIS<i></i></a></li>
            <!-- <li><a class="switcher" id="s_json" href="{{url_format}}.json">JSON<i></i></a></li> -->
          </ul>
        </div>

        <div class="code-definition-container code_visible" id="s_html_code">
          <p>Definition: Well Known Text (WKT)</p>
          <ul>
            <li><a href="{{url_format}}.prettywkt">Open</a></li>
            <li><a id="s_html_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.prettywkt" href="#">Copy URL</a></li>
            <li><a id="s_html_copyText" class="zeroclipboard" data-clipboard-target="s_html_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.prettywkt?download">Download</a></li>

          </ul>
          <div class="syntax">
            {{!export_html}}
          </div>
          <div class="syntax">
            <pre id="s_html_text">{{export['prettywkt']}}</pre>
          </div>
        </div>

        <div class="code-definition-container" id="s_esriwkt_code">
          <p>Definition: ESRI WKT</p>
          <ul>
            <li><a href="{{url_format}}.esriwkt">Open</a></li>
            <li><a id="s_esriwkt_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.esriwkt" href="#">Copy URL</a></li>
            <li><a id="s_esriwkt_copyText" class="zeroclipboard" data-clipboard-target="s_esriwkt_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.esriwkt?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_esriwkt_text">{{export['esriwkt']}}</pre>

          </div>
        </div>

        <div class="code-definition-container" id="s_proj4_code">
          <p>Definition: PROJ.4</p>
          <ul>
            <li><a href="{{url_format}}.proj4">Open</a></li>
            <li><a id="s_proj4_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.proj4" href="#">Copy URL</a></li>
            <li><a id="s_proj4_copyText" class="zeroclipboard" data-clipboard-target="s_proj4_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.proj4?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_proj4_text">{{export['proj4']}}</pre>
          </div>
        </div>

        <div class="code-definition-container" id="s_proj4js_code">
          <p>Definition: JavaScript (Proj4js) </p>
          <ul>
            <li><a href="{{url_format}}.js">Open</a></li>
            <li><a id="s_proj4js_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.js" href="#">Copy URL</a></li>
            <li><a id="s_proj4js_copyText" class="zeroclipboard" data-clipboard-target="s_proj4js_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.js?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_proj4js_text">{{export['proj4js']}}</pre>
          </div>
        </div>
        %if ogpxml != "":
          <div class="code-definition-container" id="s_gml_code">
            <p>Definition: OGC GML</p>
            <ul>
              <li><a href="{{url_format}}.gml">Open</a></li>
              <li><a id="s_gml_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.gml" href="#">Copy URL</a></li>
              <li><a id="s_gml_copyText" class="zeroclipboard" data-clipboard-target="s_gml_text" href="#">Copy TEXT</a></li>
              <li><a href="{{url_format}}.gml?download">Download</a></li>

            </ul>
            <div class="syntax">
              {{!ogpxml_highlight}}
            </div>
            <div class="syntax">
              <pre id="s_gml_text">{{ogpxml}}</pre>
            </div>
          </div>
        %end

        %if export['xml'] != "":
          <div class="code-definition-container" id="s_xml_code">
            <p>Definition: XML</p>
            <ul>
              <li><a href="{{url_format}}.xml">Open</a></li>
              <li><a id="s_xml_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.xml" href="#">Copy URL</a></li>
              <li><a id="s_xml_copyText" class="zeroclipboard" data-clipboard-target="s_xml_text" href="#">Copy TEXT</a></li>
              <li><a href="{{url_format}}.xml?download">Download</a></li>

            </ul>
            <div class="syntax">
              {{!xml_highlight}}
            </div>
            <div class="syntax">
              <pre id="s_xml_text">{{export['xml']}}</pre>
            </div>
          </div>
        %end

        <div class="code-definition-container" id="s_geoserver_code">
          <p>Definition: GeoServer</p>
          <ul>
            <li><a href="{{url_format}}.geoserver">Open</a></li>
            <li><a id="s_geoserver_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.geoserver" href="#">Copy URL</a></li>
            <li><a id="s_geoserver_copyText" class="zeroclipboard" data-clipboard-target="s_geoserver_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.geoserver?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_geoserver_text">{{export['geoserver']}}</pre>
          </div>
        </div>

        <div class="code-definition-container" id="s_mapfile_code">
          <p>Definition: MapServer - MAPfile</p>
          <ul>
            <li><a href="{{url_format}}.mapfile">Open</a></li>
            <li><a id="s_mapfile_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.mapfile" href="#">Copy URL</a></li>
            <li><a id="s_mapfile_copyText" class="zeroclipboard" data-clipboard-target="s_mapfile_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.mapfile?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_mapfile_text">{{!export['mapfile']}}</pre>
          </div>
     <!--</div>
        <div class="code-definition-container" id="s_mapserverpython_code"> -->
          <p>Definition: MapServer - Python</p>
          <ul>
            <li><a href="{{url_format}}.mapserverpython">Open</a></li>
            <li><a id="s_mapserverpython_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.mapserverpython" href="#">Copy URL</a></li>
            <li><a id="s_mapserverpython_copyText" class="zeroclipboard" data-clipboard-target="s_mapserverpython_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.mapserverpython?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_mapserverpython_text">{{!export['mapserverpython']}}</pre>
          </div>
        </div>

        <div class="code-definition-container" id="s_mapnik_code">
          <p>Definition: Mapnik</p>
          <ul>
            <li><a href="{{url_format}}.mapnik">Open in new page</a></li>
            <li><a id="s_mapnik_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.mapnik" href="#">Copy URL</a></li>
            <li><a id="s_mapnik_copyText" class="zeroclipboard" data-clipboard-target="s_mapnik_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.mapnik?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_mapnik_text">{{export['mapnik']}}</pre>
          </div>
     <!--</div>
        <div class="code-definition-container" id="s_mapnikpython_code"> -->
          <p>Definition: Mapnik - Python</p>
          <ul>
            <li><a href="{{url_format}}.mapnikpython">Open</a></li>
            <li><a id="s_mapnikpython_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.mapnikpython" href="#">Copy URL</a></li>
            <li><a id="s_mapnikpython_copyText" class="zeroclipboard" data-clipboard-target="s_mapnikpython_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.mapnikpython?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_mapnikpython_text">{{!export['mapnikpython']}}</pre>
          </div>
        </div>

        <div class="code-definition-container" id="s_postgis_code">
          <p>Definition: SQL (PostGIS)</p>
          <ul>
            <li><a href="{{url_format}}.sql">Open</a></li>
            <li><a id="s_postgis_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.sql" href="#">Copy URL</a></li>
            <li><a id="s_postgis_copyText" class="zeroclipboard" data-clipboard-target="s_postgis_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.sql?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_postgis_text">{{!export['postgis']}}</pre>
          </div>
        </div>

        <div class="code-definition-container" id="s_wkt_code">
          <p>Definition: OGC WKT</p>
          <ul>
            <li><a href="{{url_format}}.wkt">Open</a></li>
            <li><a id="s_wkt_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.wkt" href="#">Copy URL</a></li>
            <li><a id="s_wkt_copyText" class="zeroclipboard" data-clipboard-target="s_wkt_text" href="#">Copy TEXT</a></li>
            <li><a href="{{url_format}}.wkt?download">Download</a></li>

          </ul>
          <div class="syntax">
            <pre id="s_wkt_text">{{!export['ogcwkt']}}</pre>
          </div>
        </div>

        %if export['usgs'] != "":
          <div class="code-definition-container" id="s_usgs_code">
            <p>Definition: USGS</p>
            <ul>
              <li><a href="{{url_format}}.usgs">Open</a></li>
              <li><a id="s_usgs_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.usgs" href="#">Copy URL</a></li>
              <li><a id="s_usgs_copyText" class="zeroclipboard" data-clipboard-target="s_usgs_text" href="#">Copy TEXT</a></li>
              <li><a href="{{url_format}}.usgs?download">Download</a></li>

            </ul>
            <div class="syntax">
              <pre id="s_usgs_text">{{!export['usgs']}}</pre>
            </div>
          </div>
        %end

        %elif ogpxml:
          <div id="eb-menu-container">
            <h4>Export</h4>
            <ul id="eb-menu">
              <li><a class="switcher switcher_selected" id="s_gml" href="{{url_format}}.gml">OGP XML<i></i></a></li>
            </ul>
          </div>

          <div class="code-definition-container code_visible" id="s_gml_code">
            <p>Definition: OGP XML</p>
            <ul>
              <li><a href="{{url_format}}.gml">Open</a></li>
              <li><a id="s_gml_copyUrl" class="zeroclipboard" data-clipboard-text="//epsg.io{{url_format}}.gml" href="#">Copy URL</a></li>
              <li><a id="s_gml_copyText" class="zeroclipboard" data-clipboard-target="s_gml_text" href="#">Copy TEXT</a></li>
              <li><a href="{{url_format}}.gml?download">Download</a></li>

            </ul>
            <div class="syntax">
              {{!ogpxml_highlight}}
            </div>
            <div class="syntax">
              <pre id="s_gml_text">{{ogpxml}}</pre>
            </div>
          </div>
        %end
      </div>
      %if found_trans == False:
        <div id="projected-link">
            %if projcrs_by_gcrs:
              %if kind == "Projected coordinate system":
                <h3>Coordinates with same geodetic base (<a href="/{{item['geogcrs'][0]}}">{{item['geogcrs'][1]}}</a>):</h3>
              %else:
                <h3>Coordinates using this {{kind.lower()}}:</h3>
              %end
            %end

            %for r in projcrs_by_gcrs:
              <a href="/{{r['result']['code']}}">EPSG:{{r['result']['code']}} {{r['result']['name']}}</a>
              %if r['result']['code_trans']:
                <a href="{{r['result']['code']}}/map"> (map)</a> <br />
              %else:
                <br />
              %end
            %end

            %if more_gcrs_result:
              <a href="{{more_gcrs_result}}">More</a>
            %end
          </div>
        %end

</div>

     
       <script type="text/javascript">detail_init();</script>

        <div id="footer">    
          <div id="foot">
			    <p>Copyright &copy; 2016 Geoscience Division, Pacific Community (SPC)</p>
        		<p id="copyright">Powered by EPSG database {{version}}</p>
          </div>
        </div>

      </body>

    </html>
  </body>
</html>
