<script setup lang="ts">
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap/dist/js/bootstrap.js";

const emit = defineEmits<{
    (e: 'startVote'): void
}>()

</script>

<template>
    <div class="container py-2">
        <div class="row justify-content-center">
            <button class="btn btn-primary" v-on:click="emit('startVote')">Start vote</button>
        </div>
    </div>
</template>

<style scoped>

</style>