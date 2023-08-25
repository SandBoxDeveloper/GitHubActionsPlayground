package com.toolbox.githubactionsplayground

import androidx.fragment.app.testing.FragmentScenario
import androidx.fragment.app.testing.launchFragmentInContainer
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.espresso.matcher.ViewMatchers.withText
import org.junit.After
import org.junit.Before
import org.junit.Test

class ExampleUITest {

    private lateinit var fragmentScenario: FragmentScenario<FirstFragment>

    @Before
    fun setUp() {
        fragmentScenario = launchFragmentInContainer()
    }

    @After
    fun tearDown() {
        fragmentScenario.close()
    }

    @Test
    fun basicCheckForTextViews() {
        onView(withId(R.id.textview_first)).check(matches(withText("Hello first fragment")))
    }

    @Test
    fun basicCheckForButtons() {
        onView(withId(R.id.button_first)).check(matches(withText("Next")))
    }
}