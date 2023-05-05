<script setup lang="ts">

const addProposal = () => {

}
</script>

<template>
    <div class="container">
        <div class="row my-4">
            <div class="col-8">
                <label for="addedProposal" class="form-label">Make a proposal</label>
                <input class="form-control" type="text" id="addedProposal"/>
            </div>
            <div class="col-4 d-grid my-auto">
                <button class="btn btn-primary btn-block" id="buttonAdd" v-on:click="addProposal">Submit proposal
                </button>
            </div>
        </div>
    </div>
</template>

<style scoped>

</style>