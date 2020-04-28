<?php

namespace taskforce\core;

class Task {

	const STATUS_NEW		= 'new'; 		// Задание опубликовано, исполнитель ещё не найден
	const STATUS_CANCELED	= 'canceled'; 	// Заказчик отменил задание
	const STATUS_IN_WORK 	= 'in_work'; 	// Заказчик выбрал исполнителя для задания
	const STATUS_DONE 		= 'done'; 		// Заказчик отметил задание как выполненное
	const STATUS_FAILED 	= 'failed'; 	// Исполнитель отказался от выполнения задания

	const ACTION_CANCEL 	= 'action_cancel'; 	// Отменить задание закзчиком
	const ACTION_RESPOND 	= 'action_respond'; // Откликнуться на задание исполнителем
	const ACTION_APPLY 		= 'action_apply'; 	// Принять задание как выполеное заказчиком
	const ACTION_FAIL 		= 'action_fail'; 	// Отказаться от выполения

	private $current_status = self::STATUS_NEW;

	private $customer_id;

	private $freelancer_id;

	public function __construct($customer_id, $freelancer_id)
	{
		$this->customer_id 		= $customer_id;
		$this->freelancer_id 	= $freelancer_id;
	}

	/**
	 * Выводит текущий статус задания
	 * 
	 * @return string
	 */
	public function getStatus():string
	{
		return $this->current_status;
	}

	/**
	 * Устанавливает текущий статус задания
	 * 
	 * @param $value статус
	 * 
	 * @return Task
	 */
	public function setStatus($value): Task
	{
		$this->current_status = $value;

		return $this;
	}

	/**
	 * Выводит карту статусов
	 * 
	 * @return array
	 */
	public function getStatusMap(): array
	{
		return [
			self::STATUS_NEW 		=> 'Новое',
			self::STATUS_CANCELED 	=> 'Отменено',
			self::STATUS_IN_WORK 	=> 'В работе',
			self::STATUS_DONE 		=> 'Выполенео',
			self::STATUS_FAILED 	=> 'Провалено',
		];	
	}

	/**
	 * Выводит карту действий
	 * 
	 * @return array
	 */	
	public function getActionMap(): array
	{
		return [
			self::ACTION_CANCEL 	=> 'Отменить',
			self::ACTION_RESPOND 	=> 'Откликнуться',
			self::ACTION_APPLY 		=> 'Выполнено',
			self::ACTION_FAIL 		=> 'Отказаться',
		];
	}

	/**
	 * Выводит статус после действия
	 * 
	 * @param $action действие
	 * 
	 * @return string|null, если после действия статус не поменяется
	 */
	public function getNextStatus($action): ?string
	{
		$action_status = [
			self::ACTION_CANCEL => self::STATUS_CANCELED,
			self::ACTION_APPLY => self::STATUS_DONE,
			self::ACTION_FAIL => self::STATUS_FAILED,
		];

		return $action_status[$action] ?? null;
	}

	/**
	 * Выводит возможное действие для данного пользователя
	 * 
	 * @param $user_id id пользователя
	 * 
	 * @return string
	 */
	public function getActionList($user_id): string
	{
		if ($this->isCustomer($user_id)) {

			return $this->getCustomerActionList();
		}

		if ($this->isFreelancer($user_id)) {

			return $this->getFreelancerActionList();
		}
	}

	/**
	 * Проверяет роль заказчика
	 * 
	 * @param $user_id id пользоватля
	 * 
	 * @return bool
	 */
	private function isCustomer($user_id): bool
	{
		return $user_id == $this->customer_id;
	}

	/**
	 * Проверяет роль фрилансера
	 * 
	 * @param $user_id id пользоватля
	 * 
	 * @return bool
	 */
	private function isFreelancer($user_id): bool
	{
		return $user_id == $this->freelancer_id;
	}
	
	/**
	 * Выводит возможное действие для заказчика
	 * 
	 * @return string|null
	 */
	private function getCustomerActionList(): ?string
	{
		$customer_actions = [
			self::STATUS_NEW => self::ACTION_CANCEL,
			self::STATUS_IN_WORK => self::ACTION_APPLY,
		];

		return $customer_actions[$this->current_status] ?? null;
	}

	/**
	 * Выводит возможное действие для фрилансера
	 * 
	 * @return string|null
	 */
	private function getFreelancerActionList(): ?string
	{
		$freelancer_actions = [
			self::STATUS_NEW => self::ACTION_RESPOND,
			self::STATUS_IN_WORK => self::ACTION_FAIL,
		];

		return $freelancer_actions[$this->current_status] ?? null;
	}
}
