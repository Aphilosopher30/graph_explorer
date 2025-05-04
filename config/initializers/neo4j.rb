require 'neo4j-ruby-driver'

# NEO4J_URI = 'neo4j://localhost:7687'
# NEO4J_USER = 'neo4j'
# NEO4J_PASSWORD = 'password_test'

driver = Neo4j::Driver::GraphDatabase.driver("bolt://localhost:7687", Neo4j::Driver::AuthTokens.basic("neo4j", "password"))


$neo4j_driver = Neo4j::Driver::GraphDatabase.driver(
  NEO4J_URI, Neo4j::Driver::AuthTokens.basic(NEO4J_USER, NEO4J_PASSWORD)
)

at_exit { $neo4j_driver.close }
