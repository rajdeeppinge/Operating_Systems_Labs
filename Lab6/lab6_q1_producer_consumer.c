#include<stdio.h>
#include<stdlib.h>
#include<pthread.h>
#include<semaphore.h>

#define NUM_THREADS 2
#define N 100


typedef sem_t Semaphore;

Semaphore *make_semaphore(int value);
void semaphore_wait(Semaphore *sem);
void semaphore_signal(Semaphore *sem);

Semaphore *make_semaphore(int value)
{
  Semaphore *sem = malloc(sizeof(Semaphore));
  int n = sem_init(sem, 0, value);
  return sem;
}

void semaphore_wait(Semaphore *sem)
{
  int n = sem_wait(sem);
}

void semaphore_signal(Semaphore *sem)
{
  int n = sem_post(sem);
}


Semaphore *mutex, *items, *spaces;


void *producer() {
	int * val; 
	
	int i = 0;
	for(i = 0; i < 100; i++)
	{
		semaphore_wait(spaces);
		semaphore_wait(mutex);
		
		sem_getvalue(spaces, val);
		
		printf("producer iteration = %d, Index = %d\n", i, N-*val);
		
		semaphore_signal(mutex);
		semaphore_signal(items);
		
		sleep(5);	
	}
	
	pthread_exit(NULL);
}

void *consumer() {
	int * val; 
	
	int i = 0;
	for(i = 0; i < 100; i++)
	{
		semaphore_wait(items);
		semaphore_wait(mutex);
		
		sem_getvalue(items, val);
		
		printf("consumer iteration = %d, Index = %d\n", i, *val);
		
		semaphore_signal(mutex);
		semaphore_signal(spaces);	
		
		sleep(2);
	}
	
	pthread_exit(NULL);
}


int main()
{	
	mutex = make_semaphore(1);       //-- new
	items = make_semaphore(1);       //-- new
	spaces = make_semaphore(N-1);      //-- new
	
	pthread_attr_t attr;
	
	pthread_t threads[NUM_THREADS];
	
	pthread_attr_init(&attr);
	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
	
	pthread_create(&threads[0], &attr, producer, NULL);
	pthread_create(&threads[1], &attr, consumer, NULL);
	
	pthread_join(threads[0], NULL);
	pthread_join(threads[1], NULL);
	
	sem_destroy(mutex);
	sem_destroy(items);
	sem_destroy(spaces);
	
	return 0;
}
