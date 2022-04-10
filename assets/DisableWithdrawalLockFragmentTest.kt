package com.crypto.exchange.feature.withdrawal.withdrawWhitelist

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.fragment.app.testing.FragmentScenario
import androidx.lifecycle.MutableLiveData
import androidx.test.annotation.UiThreadTest
import androidx.test.espresso.Espresso
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.matcher.ViewMatchers
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.adevinta.android.barista.interaction.BaristaClickInteractions.clickOn
import com.crypto.exchange.core.model.SingleLiveEvent
import com.crypto.exchange.core.utils.ToastUtil
import com.crypto.exchange.feature.withdrawal.R
import com.crypto.exchange.feature.withdrawal.withdrawWhitelist.lock.DisableWithdrawalLockViewModel
import com.crypto.exchange.feature.withdrawal.withdrawWhitelist.lock.EnableWithdrawalLockFragment
import com.crypto.exchange.feature.withdrawal.withdrawWhitelist.lock.EnableWithdrawalLockViewModel
import com.crypto.exchange.test_shared.base.BaseFragmentScenarioTest
import io.mockk.every
import io.mockk.mockk
import io.mockk.verify
import kotlinx.coroutines.ExperimentalCoroutinesApi
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.core.module.Module
import org.koin.dsl.module

@ExperimentalCoroutinesApi
@RunWith(AndroidJUnit4::class)
class DisableWithdrawalLockFragmentTest : BaseFragmentScenarioTest(config = Config(requireNavController = true)) {
    @get:Rule
    var instantTaskRule = InstantTaskExecutorRule()

    private val viewModel by lazy { mockk<DisableWithdrawalLockViewModel>(relaxed = true) }
    private val toastUtil by lazy { mockk<ToastUtil>(relaxed = true) }

    override fun otherKoinModules(): List<Module> {
        return listOf(
            module {
                viewModel { viewModel }
                single { toastUtil }
            }
        )
    }

    @Before
    @UiThreadTest
    override fun setUp() {
        super.setUp()
        testNavController.apply {
            setGraph(R.navigation.navigation_withdrawal_whitelist)
            setCurrentDestination(R.id.fEnableWithdrawalLockFragment)
        }
    }

    @Test
    fun button_is_enabled_when_state_is_enabled() {
        every { viewModel.smsOtpResendCountdown } returns MutableLiveData(EnableWithdrawalLockViewModel.UiState(false, true))

        openEnableWithdrawalLockFragment()

        Espresso.onView(ViewMatchers.withId(R.id.btn_enable))
            .check(ViewAssertions.matches(ViewMatchers.isEnabled()))
    }

    @Test
    fun should_show_toast_on_completed_event() {
        val completeEvent = SingleLiveEvent<Unit>()
        every { viewModel.uiState } returns MutableLiveData(EnableWithdrawalLockViewModel.UiState(false, true))
        every { viewModel.completedEvent } returns completeEvent

        openEnableWithdrawalLockFragment()
        completeEvent.call()

        verify { toastUtil.showTopToast(allAny(), allAny(), allAny()) }
    }

    @Test
    fun should_show_loading_when_state_is_loading() {
        every { viewModel.uiState } returns MutableLiveData(EnableWithdrawalLockViewModel.UiState(true, true))

        openEnableWithdrawalLockFragment()

        Espresso.onView(ViewMatchers.withId(R.id.pbLoading))
            .check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
    }

    @Test
    fun button_is_disabled_when_state_is_disabled() {
        every { viewModel.uiState } returns MutableLiveData(EnableWithdrawalLockViewModel.UiState(false, false))

        openEnableWithdrawalLockFragment()

        Espresso.onView(ViewMatchers.withId(R.id.btn_enable))
            .check(ViewAssertions.matches(ViewMatchers.isNotEnabled()))
    }

    @Test
    fun button_click_will_call_viewmodel() {
        // given
        every { viewModel.uiState } returns MutableLiveData(EnableWithdrawalLockViewModel.UiState(false, true))
        // when
        openEnableWithdrawalLockFragment()
        clickOn(R.id.btn_enable)

        // then
        verify { viewModel.onEnableClick() }
    }

    private fun openEnableWithdrawalLockFragment(): FragmentScenario<EnableWithdrawalLockFragment> {
        return launchFragmentInContainerWithNavController(themeResId = R.style.AppTheme) {
            EnableWithdrawalLockFragment()
        }
    }
}
