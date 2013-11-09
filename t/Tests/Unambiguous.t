use strict;
use warnings FATAL => 'all';

use UR;

use Test::More;
use File::Temp;

use TestHelpers qw(
    diff_ast_files
    diff_xml_files
);
use Compiler;

(my $input_file = __FILE__) =~ s/\.t$/.gms/;
my $test_data_directory = __FILE__ . '.data';
my $output_directory = File::Temp::tempdir(CLEANUP => 1);

my $cmd = Compiler->create(
    input_file => $input_file,
    output_directory => $output_directory,
);

ok($cmd->execute, 'command ran') || die;
diff_ast_files(
    File::Spec->join($test_data_directory, 'ast'),
    File::Spec->join($output_directory, 'ast')
);
diff_xml_files(
    File::Spec->join($test_data_directory, 'workflow.xml'),
    File::Spec->join($output_directory, 'workflow.xml')
);

done_testing();
