<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
				<meta name="keywords" content="Candes.m,Convex Iteration,Optimization Videos" />
		<link rel="shortcut icon" href="http://convexoptimization.com/wikimization/favicon.ico" />
		<link rel="search" type="application/opensearchdescription+xml" href="/wikimization/opensearch_desc.php" title="Wikimization (English)" />
		<title>Candes.m - Wikimization</title>
		<style type="text/css" media="screen, projection">/*<![CDATA[*/
			@import "/wikimization/skins/common/shared.css?97";
			@import "/wikimization/skins/monobook/main.css?97";
		/*]]>*/</style>
		<link rel="stylesheet" type="text/css" media="print" href="/wikimization/skins/common/commonPrint.css?97" />
		<!--[if lt IE 5.5000]><style type="text/css">@import "/wikimization/skins/monobook/IE50Fixes.css?97";</style><![endif]-->
		<!--[if IE 5.5000]><style type="text/css">@import "/wikimization/skins/monobook/IE55Fixes.css?97";</style><![endif]-->
		<!--[if IE 6]><style type="text/css">@import "/wikimization/skins/monobook/IE60Fixes.css?97";</style><![endif]-->
		<!--[if IE 7]><style type="text/css">@import "/wikimization/skins/monobook/IE70Fixes.css?97";</style><![endif]-->
		<!--[if lt IE 7]><script type="text/javascript" src="/wikimization/skins/common/IEFixes.js?97"></script>
		<meta http-equiv="imagetoolbar" content="no" /><![endif]-->

		<script type= "text/javascript">/*<![CDATA[*/
var skin = "monobook";
var stylepath = "/wikimization/skins";
var wgArticlePath = "/wikimization/index.php/$1";
var wgScriptPath = "/wikimization";
var wgScript = "/wikimization/index.php";
var wgServer = "http://www.convexoptimization.com";
var wgCanonicalNamespace = "";
var wgCanonicalSpecialPageName = false;
var wgNamespaceNumber = 0;
var wgPageName = "Candes.m";
var wgTitle = "Candes.m";
var wgAction = "view";
var wgRestrictionEdit = ["autoconfirmed"];
var wgRestrictionMove = ["autoconfirmed"];
var wgArticleId = "38";
var wgIsArticle = true;
var wgUserName = null;
var wgUserGroups = null;
var wgUserLanguage = "en";
var wgContentLanguage = "en";
var wgBreakFrames = false;
var wgCurRevisionId = "2030";
/*]]>*/</script>

		<script type="text/javascript" src="/wikimization/skins/common/wikibits.js?97"><!-- wikibits js --></script>
		<script type="text/javascript" src="/wikimization/index.php?title=-&amp;action=raw&amp;gen=js&amp;useskin=monobook"><!-- site js --></script>
		<style type="text/css">/*<![CDATA[*/
@import "/wikimization/index.php?title=MediaWiki:Common.css&usemsgcache=yes&action=raw&ctype=text/css&smaxage=18000";
@import "/wikimization/index.php?title=MediaWiki:Monobook.css&usemsgcache=yes&action=raw&ctype=text/css&smaxage=18000";
@import "/wikimization/index.php?title=-&action=raw&gen=css&maxage=18000";
/*]]>*/</style>
		<!-- Head Scripts -->
		<script type="text/javascript" src="/wikimization/skins/common/ajax.js?97"></script>
	</head>
<body  class="mediawiki ns-0 ltr page-Candes_m">
	<div id="globalWrapper">
		<div id="column-content">
	<div id="content">
		<a name="top" id="top"></a>
				<h1 class="firstHeading">Candes.m</h1>
		<div id="bodyContent">
			<h3 id="siteSub">From Wikimization</h3>
			<div id="contentSub"></div>
									<div id="jump-to-nav">Jump to: <a href="#column-one">navigation</a>, <a href="#searchInput">search</a></div>			<!-- start content -->
			<p>This Matlab demonstration of <i>compressive sampling</i> (<tt>a.k.a.</tt> <i>compressed sensing</i>) by <a href="http://www.acm.caltech.edu/~emmanuel" class="external text" title="http://www.acm.caltech.edu/~emmanuel" rel="nofollow">Emmanuel Candès</a><br /> comes from his <a href="http://www.convexoptimization.com/wikimization/index.php/Optimization_Videos#June_6_2007_.C2.A0Sparsity_and_Incoherence" class="external text" title="http://www.convexoptimization.com/wikimization/index.php/Optimization_Videos#June_6_2007_.C2.A0Sparsity_and_Incoherence" rel="nofollow">June 6 2007</a> video on the <a href="/wikimization/index.php/Optimization_Videos" title="Optimization Videos">Optimization Videos</a> page.
</p>
<pre>
%Emmanuel Candes, California Institute of Technology, June 6 2007, IMA Summerschool.
%Transcribed by Jon Dattorro.
%Fails using SDP solver SDPT3  on 7th consecutive run after Matlab R2007b startup.  CVX version 1.2 (build 656).
%Fails using SDP solver Sedumi on 4th consecutive run after Matlab R2007b startup.  CVX version 1.2 (build 656).
clear all, close all                
n = 512;                           &nbsp;% Size of signal
m = 64;                            &nbsp;% Number of samples (undersample by a factor 8)

k = 0:n-1;  t = 0:n-1;
F = exp(-i*2*pi*k'*t/n)/sqrt(n);   &nbsp;% Fourier matrix
freq = randsample(n,m);
A = [real(F(freq,:)); 
     imag(F(freq,:))];             &nbsp;% Incomplete Fourier matrix

S = 28;
support = randsample(n,S);
x0 = zeros(n,1);  x0(support) = randn(S,1);
b = A*x0;

% Solve l1 using CVX
cvx_quiet(true);
%cvx_solver('sedumi'); 
cvx_begin
    variable x(n);
    minimize(norm(x,1));
    A*x == b;
cvx_end

norm(x - x0)/norm(x0)
figure, plot(1:n,x0,'b*',1:n,x,'ro'), legend('original','decoded')
</pre>
<p>Code between <code>cvx_begin</code> and <code>cvx_end</code> requires <a href="http://www.stanford.edu/~boyd/cvx" class="external text" title="http://www.stanford.edu/~boyd/cvx" rel="nofollow">CVX</a>.
</p><p><code>randsample()</code> is from Matlab Statistics Toolbox.
</p>
<a name="Revision"></a><h3> <span class="mw-headline"> Revision </span></h3>
<p>Failure modes are reparable by <a href="/wikimization/index.php/Convex_Iteration" title="Convex Iteration">Convex Iteration</a> from <a href="http://www.convexoptimization.com/TOOLS/0976401304.pdf" class="external text" title="http://www.convexoptimization.com/TOOLS/0976401304.pdf" rel="nofollow"><i>Convex Optimization &amp; Euclidean Distance Geometry</i>, Ch.4.5</a>:
</p>
<pre>
%Emmanuel Candes, California Institute of Technology, June 6 2007, IMA Summerschool.
%Convex Iteration implementation by Jon Dattorro.
%Failure modes repaired.
clear all, close all
n = 512;                           &nbsp;% Size of signal
m = 64;                            &nbsp;% Number of samples (undersample by a factor 8)

k = 0:n-1;  t = 0:n-1;
F = exp(-i*2*pi*k'*t/n)/sqrt(n);   &nbsp;% Fourier matrix
freq = randsample(n,m);
A = [real(F(freq,:));
     imag(F(freq,:))];             &nbsp;% Incomplete Fourier matrix

S = 28;
support = randsample(n,S);
x0 = zeros(n,1);  x0(support) = randn(S,1);
b = A*x0;

cvx_quiet(true);
%cvx_solver('sedumi');

%convex iteration
y = ones(n,1);
while 1
   &nbsp;% Solve l0 using CVX and Convex Iteration
    cvx_begin
        variable x(n);
        minimize(norm(y.*x,1));
        A*x == b;
    cvx_end

   &nbsp;% update search direction y
    [x_sorted, indices] = sort(abs(x), 'descend');  
    y = ones(n,1);
    y(indices(1:S)) = 0;

    cardx = sum(abs(x) &gt; 1e-6)
    if cardx &lt;= S, break, end
end
norm(x - x0)/norm(x0)
figure, plot(1:n,x0,'b*',1:n,x,'ro'), legend('original','decoded')
</pre>

<!-- Saved in parser cache with key dattorro_wiki:pcache:idhash:38-0!1!0!!en!2!edit=0 and timestamp 20120317011716 -->
<div class="printfooter">
Retrieved from "<a href="http://www.convexoptimization.com/wikimization/index.php/Candes.m">http://www.convexoptimization.com/wikimization/index.php/Candes.m</a>"</div>
						<!-- end content -->
			<div class="visualClear"></div>
		</div>
	</div>
		</div>
		<div id="column-one">
	<div id="p-cactions" class="portlet">
		<h5>Views</h5>
		<div class="pBody">
			<ul>
					 <li id="ca-nstab-main" class="selected"><a href="/wikimization/index.php/Candes.m" title="View the content page [c]" accesskey="c">Article</a></li>
					 <li id="ca-talk"><a href="/wikimization/index.php/Talk:Candes.m" title="Discussion about the content page [t]" accesskey="t">Discussion</a></li>
					 <li id="ca-viewsource"><a href="/wikimization/index.php?title=Candes.m&amp;action=edit" title="This page is protected. You can view its source. [e]" accesskey="e">View source</a></li>
					 <li id="ca-history"><a href="/wikimization/index.php?title=Candes.m&amp;action=history" title="Past versions of this page. [h]" accesskey="h">History</a></li>
				</ul>
		</div>
	</div>
	<div class="portlet" id="p-personal">
		<h5>Personal tools</h5>
		<div class="pBody">
			<ul>
				<li id="pt-login"><a href="/wikimization/index.php?title=Special:Userlogin&amp;returnto=Candes.m" title="You are encouraged to log in, it is not mandatory however. [o]" accesskey="o">Log in / create account</a></li>
			</ul>
		</div>
	</div>
	<div class="portlet" id="p-logo">
		<a style="background-image: url(http://convexoptimization.com/wikimization/images/ScNperp.png);" href="/wikimization/index.php/WIKIMIZATION" title="Visit the Main Page [z]" accesskey="z"></a>
	</div>
	<script type="text/javascript"> if (window.isMSIE55) fixalpha(); </script>
		<div class='portlet' id='p-navigation'>
		<h5>Navigation</h5>
		<div class='pBody'>
			<ul>
				<li id="n-mainpage"><a href="/wikimization/index.php/WIKIMIZATION" title="Visit the Main Page [z]" accesskey="z">WIKIMIZATION</a></li>
				<li id="n-Recent-Changes"><a href="/wikimization/index.php/Special:Recentchanges">Recent Changes</a></li>
				<li id="n-All-Pages"><a href="/wikimization/index.php/Special:Allpages">All Pages</a></li>
				<li id="n-Popular-Pages"><a href="/wikimization/index.php/Special:Popularpages">Popular Pages</a></li>
				<li id="n-Users"><a href="/wikimization/index.php/Special:Listusers">Users</a></li>
				<li id="n-Image-Gallery"><a href="/wikimization/index.php/Special:Newimages">Image Gallery</a></li>
				<li id="n-Newly-Created-Pages"><a href="/wikimization/index.php/Special:Newpages">Newly Created Pages</a></li>
				<li id="n-File-List"><a href="/wikimization/index.php/Special:Imagelist">File List</a></li>
				<li id="n-help"><a href="/wikimization/index.php/Help:Contents" title="The place to find out.">Help</a></li>
			</ul>
		</div>
	</div>
		<div id="p-search" class="portlet">
		<h5><label for="searchInput">Search</label></h5>
		<div id="searchBody" class="pBody">
			<form action="/wikimization/index.php/Special:Search" id="searchform"><div>
				<input id="searchInput" name="search" type="text" title="Search Wikimization [f]" accesskey="f" value="" />
				<input type='submit' name="go" class="searchButton" id="searchGoButton"	value="Go" />&nbsp;
				<input type='submit' name="fulltext" class="searchButton" id="mw-searchButton" value="Search" />
			</div></form>
		</div>
	</div>
	<div class="portlet" id="p-tb">
		<h5>Toolbox</h5>
		<div class="pBody">
			<ul>
				<li id="t-whatlinkshere"><a href="/wikimization/index.php/Special:Whatlinkshere/Candes.m" title="List of all wiki pages that link here [j]" accesskey="j">What links here</a></li>
				<li id="t-recentchangeslinked"><a href="/wikimization/index.php/Special:Recentchangeslinked/Candes.m" title="Recent changes in pages linked from this page [k]" accesskey="k">Related changes</a></li>
<li id="t-upload"><a href="/wikimization/index.php/Special:Upload" title="Upload images or media files [u]" accesskey="u">Upload file</a></li>
<li id="t-specialpages"><a href="/wikimization/index.php/Special:Specialpages" title="List of all special pages [q]" accesskey="q">Special pages</a></li>
				<li id="t-print"><a href="/wikimization/index.php?title=Candes.m&amp;printable=yes" title="Printable version of this page [p]" accesskey="p">Printable version</a></li>				<li id="t-permalink"><a href="/wikimization/index.php?title=Candes.m&amp;oldid=2030" title="Permanent link to this version of the page">Permanent link</a></li>			</ul>
		</div>
	</div>
		</div><!-- end of the left (by default at least) column -->
			<div class="visualClear"></div>
			<div id="footer">
			<ul id="f-list">
				<li id="lastmod"> This page was last modified 00:40, 16 May 2010.</li>
				<li id="viewcount">This page has been accessed 66,515 times.</li>
				<li id="about"><a href="/wikimization/index.php/Wikimization:About" title="Wikimization:About">About Wikimization</a></li>
			<span id="subfooter">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.vervehosting.com" target=blank>Hosted by Verve</a>
			</span>
			</ul>
		</div>

	
		<script type="text/javascript">if (window.runOnloadHook) runOnloadHook();</script>
</div>
<!-- Served in 0.144 secs. --></body></html>
