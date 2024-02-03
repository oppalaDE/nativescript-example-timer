<template>
  <FlexboxLayout
    justifyContent="space-around"
    flexDirection="column"
  >
    <!-- Show stopwatch counter as text -->
    <FlexboxLayout
      height="200"
      alignItems="center"
      justifyContent="space-around"
      flexDirection="column"
    >
      <Label class="readable-timer">{{ readableTimeText }}</Label>
    </FlexboxLayout>

    <StackLayout v-if="isStopwatchStarted">
      <!-- Show start button if stopwatch is not started -->
      <Button
        class="rounded-button"
        @tap="startStopwatch"
      >
        <FormattedString>
          <Span text="Start" style="color: black;"/>
        </FormattedString>
      </Button>
    </StackLayout>
    <StackLayout v-else>
      <!-- Show stop button if stopwatch is running -->
      <Button
        v-if="isStopwatchRunning"
        class="rounded-button"
        @tap="stopStopwatch"
      >
        <FormattedString>
          <Span text="Stop" style="color: black;"/>
        </FormattedString>
      </Button>
      <!-- Show start button if stopwatch is started but not running -->
      <Button
        v-else
        class="rounded-button"
        @tap="startStopwatch"
      >
        <FormattedString>
          <Span text="Start" style="color: black;"/>
        </FormattedString>
      </Button>
      <!-- Show reset button if stopwatch is started -->
      <Button
        class="rounded-button"
        @tap="resetStopwatch"
      >
        <FormattedString>
          <Span text="Reset" style="color: black;"/>
        </FormattedString>
      </Button>
    </StackLayout>
  </FlexboxLayout>
</template>

<script lang="ts">
  import Vue from "nativescript-vue";

  export default Vue.extend({
    data: () => {
      return {
        currentTime: 0,
        intervalId: null as any
      };
    },
    computed: {
      readableTimeText() {
        const totalSeconds = Math.floor(this.currentTime / 1000);
        const totalMilliseconds = this.currentTime - totalSeconds * 1000;
        const minutes = Math.floor(totalSeconds / 60);
        const seconds = totalSeconds - (minutes * 60);
        return `${String(minutes).padStart(2, '0')} : ${String(seconds).padStart(2, '0')} . ${String(totalMilliseconds / 10).padStart(2, '0')}`;
      },
      isStopwatchStarted() {
        return this.currentTime === 0;
      },
      isStopwatchRunning() {
        return this.intervalId !== null;
      }
    },
    methods: {
      startStopwatch() {
        this.intervalId = setInterval(() => {
          this.currentTime += 20;
        }, 20);
      },
      stopStopwatch() {
        if (this.isStopwatchRunning) {
          clearInterval(this.intervalId);
          this.intervalId = null;
        }
      },
      resetStopwatch() {
        this.stopStopwatch();
        this.currentTime = 0;
      },
    }
});
</script>

<style scoped lang="scss">
.readable-timer {
  font-weight: bold;
  font-size: 36;
}

.rounded-button {
  border-width: 10px;
  border-style: solid;
  border-color: black;
  border-radius: 14;
  height: 56;
  width: 128;
  text-align: center;
  color: black;
  font-size: 20;
  font-weight: 600;
  background-color: white;
}
</style>
