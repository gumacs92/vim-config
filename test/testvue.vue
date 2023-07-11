<template>
  <h1>test hello</h1>

  <div>h ello</div>
</template>
<script lang="ts" setup>
definePageMeta({});

if(true){

} else if(false){

} else {
asdfasdf
}

const tes = ref(false);

const te = computed(() => {
  return "123";
});

const test9 = () => {
  console.log("test9");
};

const test10 = () => {
  console.log("test10");
};

const test11 = () => {
  console.log("test11");
};


// functio which adds two number
const adder = (a: number, b: number) => {
  return a + b;
};

// this multiplies
const multiplier = (a: number, b: number) => {
  return a * b;
};
</script>
