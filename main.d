

import std.stdio : writeln;
import queryresults : QueryResults;
import statementclient : ClientSession, StatementClient;

version(unittest) void main() { writeln("Tests completed."); }
else void main() {

  auto session = ClientSession("localhost:8080/v1/statement", "test");
  session.catalog = "tpch";
  session.schema = "tiny";

  auto client = StatementClient(session, "SELECT * FROM orders");
  foreach (resultBatch; client) {
    writeln ("Starting a new batch");

    foreach (row; resultBatch.byRow!(string, "comment")()) {
      writeln(row);
    }
  }

}
