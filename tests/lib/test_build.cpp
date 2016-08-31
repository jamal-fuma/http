#include "TestHelper.hpp"

#include <tuple>

struct node_t
{
    using match_type    = std::tuple<int,bool>;
    using path_type     = std::tuple<node_t *,int,bool>;
    node_t(char ch)
        : m_letter{ch}
        , m_end_of_word{false}
    {
    }

    node_t()
        : m_letter{'\0'}
        , m_end_of_word{true}
    {
    }

    bool empty() const
    {
        return m_children.empty();
    }

    size_t size() const
    {
        return m_children.size();
    }

    match_type
    find(const char * begin, size_t len) const
    {
        std::cout << "trying to find a prefix of  [" << begin << "]\n";
        const node_t * node = this;
        int depth = 0;
        bool exact_match = std::all_of(begin, (begin + len), [&node,&depth](const char & ch)
        {
            int offset;
            bool found;
            std::tie(offset,found) = node->contains(ch);
            if(found)
            {
                ++depth;
                node = &node->m_children[offset];
            }
            return found;
        });
        return std::make_tuple(depth,exact_match);
    }

    void insert(const char * begin, size_t len)
    {
        node_t * root = this;

        std::for_each(begin,(begin+len),[&root](const char & ch)
        {
            int offset;
            std::tie(offset,std::ignore) = root->append(ch);
            root = &root->m_children[ offset ];
        });
    }

    match_type
    append(char ch)
    {
        int  offset;
        bool present;
        std::tie(offset,present) = contains(ch);

        if(!present)
            m_children.emplace_back(ch);

        // either where we found it, or where we put it
        return std::make_tuple(offset,(!present));
    }

    match_type
    contains(char ch) const
    {
        const auto cend = m_children.cend();
        int i = 0;
        auto position = std::find_if(m_children.cbegin(), cend, [ch,&i](const node_t & node)
        {
            ++i;
            return (node.m_letter == ch);
        });
        return std::make_tuple(i,(position != cend));
    }

    char m_letter;
    bool m_end_of_word;
    std::vector<node_t> m_children;
};


struct url_trie
{
    node_t m_root;

    bool empty() const
    {
        return m_root.empty();
    }

    void insert(const char * begin, size_t len)
    {
        m_root.insert(begin,len);
    }

    bool find(const char * begin, size_t len) const
    {
        int prefix_len;
        bool exact_match;
        std::tie(prefix_len,exact_match) = m_root.find(begin,len);

        return(exact_match || (prefix_len > 0));
    }

    bool find_exact(const char * begin, size_t len) const
    {
        int prefix_len;
        bool exact_match;
        std::tie(prefix_len,exact_match) = m_root.find(begin,len);

        return (exact_match);
    }
};


struct FixtureData
    : public Fuma::Test::Fixture
{
    url_trie routes;
};

BOOST_FIXTURE_TEST_SUITE(BasicSuite, FixtureData)

BOOST_AUTO_TEST_CASE(trie_should_start_with_no_children)
{
    BOOST_REQUIRE_EQUAL(true,routes.empty());
}

BOOST_AUTO_TEST_CASE(trie_should_not_be_emty_after_adding_a_child)
{
    std::string s1{"/hello"};
    routes.insert(&s1[0],s1.size());
    BOOST_REQUIRE_EQUAL(false,routes.empty());
}

BOOST_AUTO_TEST_CASE(trie_should_share_repeated_prefixes_at_depth_0)
{
    std::string s1{"/hello"};
    std::string s2{"/hellt"};

    routes.insert(&s1[0],s1.size());
    routes.insert(&s2[0],s2.size());

    // check the structure
    node_t * root = &routes.m_root;
    BOOST_REQUIRE(root);
    BOOST_REQUIRE_EQUAL(1,root->size());
    BOOST_REQUIRE_EQUAL('/',root->m_letter);
    BOOST_REQUIRE_EQUAL(false,root->m_end_of_word);
}

BOOST_AUTO_TEST_CASE(trie_should_share_repeated_prefixes_at_depth_1)
{
    std::string s1{"/hello"};
    std::string s2{"/hellt"};

    routes.insert(&s1[0],s1.size());
    routes.insert(&s2[0],s2.size());

    // check the structure
    node_t * root = &routes.m_root;

    BOOST_REQUIRE(root);
    BOOST_REQUIRE_EQUAL(1,root->size());
    BOOST_REQUIRE_EQUAL('h',root->m_letter);
    BOOST_REQUIRE_EQUAL(false,root->m_end_of_word);
}

BOOST_AUTO_TEST_CASE(trie_should_share_repeated_prefixes_at_depth_2)
{
    std::string s1{"/hello"};
    std::string s2{"/hellt"};

    routes.insert(&s1[0],s1.size());
    routes.insert(&s2[0],s2.size());

    // check the structure
    node_t * root = &routes.m_root;
    root = &root->m_children[0];
    root = &root->m_children[0];

    BOOST_REQUIRE(root);
    BOOST_REQUIRE_EQUAL(1,root->size());
    BOOST_REQUIRE_EQUAL('e',root->m_letter);
    BOOST_REQUIRE_EQUAL(false,root->m_end_of_word);
}

BOOST_AUTO_TEST_CASE(trie_should_share_repeated_prefixes_at_depth_3)
{
    std::string s1{"/hello"};
    std::string s2{"/hellt"};

    routes.insert(&s1[0],s1.size());
    routes.insert(&s2[0],s2.size());

    // check the structure
    node_t * root = &routes.m_root;
    root = &root->m_children[0];
    root = &root->m_children[0];
    root = &root->m_children[0];

    BOOST_REQUIRE(root);
    BOOST_REQUIRE_EQUAL(1,root->size());
    BOOST_REQUIRE_EQUAL('l',root->m_letter);
    BOOST_REQUIRE_EQUAL(false,root->m_end_of_word);
}

BOOST_AUTO_TEST_CASE(trie_should_share_repeated_prefixes_at_depth_4)
{
    std::string s1{"/hello"};
    std::string s2{"/hellt"};

    routes.insert(&s1[0],s1.size());
    routes.insert(&s2[0],s2.size());

    // check the structure
    node_t * root = &routes.m_root;
    root = &root->m_children[0];
    root = &root->m_children[0];
    root = &root->m_children[0];
    root = &root->m_children[0];

    BOOST_REQUIRE(root);
    BOOST_REQUIRE_EQUAL(2,root->size());
    BOOST_REQUIRE_EQUAL('l',root->m_letter);
    BOOST_REQUIRE_EQUAL(false,root->m_end_of_word);
}

BOOST_AUTO_TEST_SUITE_END()
