<template>
  <FlexboxLayout
    flexDirection="column"
  >
    <!-- Show progress of started timer -->
    <Progress
      v-if="isTimerStarted"
      :value="currentTimerMs"
      :maxValue="totalTimerMs"
      backgroundColor="lightgray"
      color="black"
    />
  
    <FlexboxLayout
      justifyContent="space-around"
      flexDirection="column"
      flexGrow="1"
    >
      <!-- Show timer settings if timer is not startet -->
      <FlexboxLayout
        v-if="!isTimerStarted"
        height="200"
        alignItems="center"
        justifyContent="center"
        flexDirection="row"
      >
        <ListPicker
          width="100"
          :items="Array.from({length: 60}, (v, i) => i)"
          v-model="minutes"
        />
        <Label class="unit-label" width="50">min</Label>
        <ListPicker
          width="100"
          :items="Array.from({length: 60}, (v, i) => i)"
          v-model="seconds"
        />
        <Label class="unit-label">sec</Label>
      </FlexboxLayout>
      <FlexboxLayout
        v-else
        height="200"
        alignItems="center"
        justifyContent="space-around"
        flexDirection="column"
      >
        <!-- Show timer as text of started timer -->
        <Label class="readable-timer">{{ readableTimerText }}</Label>
      </FlexboxLayout>

      <FlexboxLayout
        justifyContent="space-around"
      >
        <!-- Show start button if timer is not started-->
        <Button
          v-if="!isTimerStarted"
          class="rounded-button"
          @tap="startTimer"
        >
          <FormattedString>
            <Span text="Start" style="color: black;"/>
          </FormattedString>
        </Button>
        <!-- Show start/stop and cancel button if timer is started -->
        <StackLayout v-else>
          <Button
            class="rounded-button"
            @tap="stopStartTimer"
          >
            <FormattedString>
              <Span :text="intervalId === null ? 'Start' : 'Stop'" style="color: black;"/>
            </FormattedString>
          </Button>
          <Button
            class="rounded-button"
            @tap="cancelTimer"
          >
            <FormattedString>
              <Span text="Cancel" style="color: black;"/>
            </FormattedString>
          </Button>
        </StackLayout>
      </FlexboxLayout>
    </FlexboxLayout>
  </FlexboxLayout>
</template>

<script lang="ts">
  import Vue from "nativescript-vue";
  import { Dialogs } from '@nativescript/core';

  export default Vue.extend({
    data: () => {
      return {
        minutes: 0,
        seconds: 30,
        currentTimerMs: 0,
        intervalId: null as any
      };
    },
    computed: {
      totalTimerMs() {
        return (this.minutes * 60 + this.seconds) * 1000;
      },
      readableTimerText() {
        const totalSeconds = Math.floor(this.currentTimerMs / 1000);
        const minutes = Math.floor(totalSeconds / 60);
        const seconds = totalSeconds - (minutes * 60);
        return `${String(minutes).padStart(2, '0')} : ${String(seconds).padStart(2, '0')}`;
      },
      isTimerStarted() {
        return this.currentTimerMs > 0;
      }
    },
    methods: {
      startInterval() {
        this.intervalId = setInterval(() => {
          this.currentTimerMs -= 100;
          if (this.currentTimerMs <= 0 && this.intervalId) {
            clearInterval(this.intervalId);
            this.intervalId = null;
            this.currentTimerMs = 0;
            Dialogs.alert({
              title: 'Timer finished',
              okButtonText: 'OK',
              cancelable: true,
            });
          }
        }, 100);
      },
      startTimer() {
          this.currentTimerMs = this.totalTimerMs;
          this.startInterval();
      },
      stopStartTimer() {
        if (this.intervalId) {
          clearInterval(this.intervalId);
          this.intervalId = null;
        } else {
          this.startInterval();
        }
      },
      cancelTimer() {
        if (this.intervalId) {
          clearInterval(this.intervalId);
          this.intervalId = null;
        }
        this.currentTimerMs = 0;
      }
    }
  });
</script>

<style scoped lang="scss">
.unit-label {
  font-weight: 600;
  font-size: 20;
}

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
