#!/usr/bin/perl
use Cwd;
$| = 1;

sub check_wget(){
	$result = sprintf(`which wget`);
	if(length($result)==0){
		die "Please install Wget.\n";
	}
	return;
}

sub check_tree(){
	$result = sprintf(`which tree`);
	if(length($result)==0){
		die "Please install Tree.\n";
	}
	return;
}

#main() function:
&check_wget();
&check_tree();
print("URL\(e.g. \"https://192.168.0.22:5001/\" OR \"http://www.microsoft.com/\"\): ");
$url = <STDIN>;
chop($url);
if($url=~/(.*):\/\/(.*)\//){
	$protocol = $1;
	$server = $2;
}else{
	die "The format of $url is problematic!\nThe correct format should be like \"https://192.168.0.22:5001/\" OR \"http://www.microsoft.com/\".\n";
}
system("wget --protocol-directories -r $url > /dev/null 2>\&1");
$current_path = getcwd();
$path = $current_path."/".$protocol."/".$server."/";
print("$url has been downloaded at $path.\n");
$structure_file = $current_path."/".$protocol."_".$server."_structure.txt";
system("tree $path > $structure_file");
print("The STRUCTURE file has been generated at $structure_file.\n");



