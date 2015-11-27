#include "TestHelper.hpp"

struct FixtureData
	: public Fuma::Test::Fixture
{
};

BOOST_FIXTURE_TEST_SUITE(BasicSuite, FixtureData)

BOOST_AUTO_TEST_CASE(should_match_hello_fixture)
{
    std::string expected = "Hello World\n";
    std::string actual = fixture_load("fixture.txt");

    BOOST_REQUIRE_EQUAL(expected,std::string(m_data.begin(),m_data.end()));
}

BOOST_AUTO_TEST_SUITE_END()
