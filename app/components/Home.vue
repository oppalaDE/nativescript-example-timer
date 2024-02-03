<template>
  <Page>
    <ActionBar :title="selectedTabIndex === 0 ? 'Timer' : 'Stopwatch'">
      <ActionItem ios.position="right">
        <GridLayout width="100">
          <Button text="About" @tap="showAbout"/>
        </GridLayout>
      </ActionItem>
    </ActionBar>

    <TabView
      v-model:selectedIndex="selectedTabIndex"
      iosIconRenderingMode="alwaysOriginal"
      androidSelectedTabHighlightColor="black"
      androidTabsPosition="bottom"
    >
      <TabViewItem :iconSource="selectedTabIndex === 0 ? '~/images/schedule-fill.png' : '~/images/schedule.png'">
        <TimerTabViewItem/>
      </TabViewItem>
      <TabViewItem :iconSource="selectedTabIndex === 1 ? '~/images/timer-fill.png' : '~/images/timer.png'">
        <StopwatchTabViewItem/>
      </TabViewItem>
    </TabView>
  </Page>
</template>

<script lang="ts">
  import Vue from "nativescript-vue";
  import StopwatchTabViewItem from './StopwatchTabViewItem.vue';
  import TimerTabViewItem from './TimerTabViewItem.vue';
  import About from './About.vue';

  export default Vue.extend({
    name: 'Home',
    components: {
      StopwatchTabViewItem,
      TimerTabViewItem,
      About
    },
    data: () => {
      return {
        selectedTabIndex: 0
      };
    },
    methods: {
      showAbout(event: any) {
        this.$navigateTo(About); // Show page as a proper page
        // this.$showModal(About); // Show page in a modal
      }
    }
});
</script>

<style scoped lang="scss">
</style>
